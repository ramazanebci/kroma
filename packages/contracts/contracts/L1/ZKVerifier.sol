// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.15;

contract ZKVerifier {
    function pairing(G1Point[] memory p1, G2Point[] memory p2) internal view returns (bool) {
        uint256 length = p1.length * 6;
        uint256[] memory input = new uint256[](length);
        uint256[1] memory result;
        bool ret;

        require(p1.length == p2.length);

        for (uint256 i = 0; i < p1.length; i++) {
            input[0 + i * 6] = p1[i].x;
            input[1 + i * 6] = p1[i].y;
            input[2 + i * 6] = p2[i].x[0];
            input[3 + i * 6] = p2[i].x[1];
            input[4 + i * 6] = p2[i].y[0];
            input[5 + i * 6] = p2[i].y[1];
        }

        assembly {
            ret := staticcall(gas(), 8, add(input, 0x20), mul(length, 0x20), result, 0x20)
        }
        require(ret);
        return result[0] != 0;
    }

    uint256 constant q_mod =
        21888242871839275222246405745257275088548364400416034343698204186575808495617;

    function fr_invert(uint256 a) internal view returns (uint256) {
        return fr_pow(a, q_mod - 2);
    }

    function fr_pow(uint256 a, uint256 power) internal view returns (uint256) {
        uint256[6] memory input;
        uint256[1] memory result;
        bool ret;

        input[0] = 32;
        input[1] = 32;
        input[2] = 32;
        input[3] = a;
        input[4] = power;
        input[5] = q_mod;

        assembly {
            ret := staticcall(gas(), 0x05, input, 0xc0, result, 0x20)
        }
        require(ret);

        return result[0];
    }

    function fr_div(uint256 a, uint256 b) internal view returns (uint256) {
        require(b != 0);
        return mulmod(a, fr_invert(b), q_mod);
    }

    function fr_mul_add(
        uint256 a,
        uint256 b,
        uint256 c
    ) internal pure returns (uint256) {
        return addmod(mulmod(a, b, q_mod), c, q_mod);
    }

    function fr_mul_add_pm(
        uint256[84] memory m,
        uint256[] calldata proof,
        uint256 opcode,
        uint256 t
    ) internal pure returns (uint256) {
        for (uint256 i = 0; i < 32; i += 2) {
            uint256 a = opcode & 0xff;
            if (a != 0xff) {
                opcode >>= 8;
                uint256 b = opcode & 0xff;
                opcode >>= 8;
                t = addmod(mulmod(proof[a], m[b], q_mod), t, q_mod);
            } else {
                break;
            }
        }

        return t;
    }

    function fr_mul_add_mt(
        uint256[84] memory m,
        uint256 base,
        uint256 opcode,
        uint256 t
    ) internal pure returns (uint256) {
        for (uint256 i = 0; i < 32; i += 1) {
            uint256 a = opcode & 0xff;
            if (a != 0xff) {
                opcode >>= 8;
                t = addmod(mulmod(base, t, q_mod), m[a], q_mod);
            } else {
                break;
            }
        }

        return t;
    }

    function fr_reverse(uint256 input) internal pure returns (uint256 v) {
        v = input;

        // swap bytes
        v =
            ((v & 0xFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00) >> 8) |
            ((v & 0x00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF) << 8);

        // swap 2-byte long pairs
        v =
            ((v & 0xFFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000) >> 16) |
            ((v & 0x0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF) << 16);

        // swap 4-byte long pairs
        v =
            ((v & 0xFFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000) >> 32) |
            ((v & 0x00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF) << 32);

        // swap 8-byte long pairs
        v =
            ((v & 0xFFFFFFFFFFFFFFFF0000000000000000FFFFFFFFFFFFFFFF0000000000000000) >> 64) |
            ((v & 0x0000000000000000FFFFFFFFFFFFFFFF0000000000000000FFFFFFFFFFFFFFFF) << 64);

        // swap 16-byte long pairs
        v = (v >> 128) | (v << 128);
    }

    uint256 constant p_mod =
        21888242871839275222246405745257275088696311157297823662689037894645226208583;

    struct G1Point {
        uint256 x;
        uint256 y;
    }

    struct G2Point {
        uint256[2] x;
        uint256[2] y;
    }

    function ecc_from(uint256 x, uint256 y) internal pure returns (G1Point memory r) {
        r.x = x;
        r.y = y;
    }

    function ecc_add(
        uint256 ax,
        uint256 ay,
        uint256 bx,
        uint256 by
    ) internal view returns (uint256, uint256) {
        bool ret = false;
        G1Point memory r;
        uint256[4] memory input_points;

        input_points[0] = ax;
        input_points[1] = ay;
        input_points[2] = bx;
        input_points[3] = by;

        assembly {
            ret := staticcall(gas(), 6, input_points, 0x80, r, 0x40)
        }
        require(ret);

        return (r.x, r.y);
    }

    function ecc_sub(
        uint256 ax,
        uint256 ay,
        uint256 bx,
        uint256 by
    ) internal view returns (uint256, uint256) {
        return ecc_add(ax, ay, bx, p_mod - by);
    }

    function ecc_mul(
        uint256 px,
        uint256 py,
        uint256 s
    ) internal view returns (uint256, uint256) {
        uint256[3] memory input;
        bool ret = false;
        G1Point memory r;

        input[0] = px;
        input[1] = py;
        input[2] = s;

        assembly {
            ret := staticcall(gas(), 7, input, 0x60, r, 0x40)
        }
        require(ret);

        return (r.x, r.y);
    }

    function _ecc_mul_add(uint256[5] memory input) internal view {
        bool ret = false;

        assembly {
            ret := staticcall(gas(), 7, input, 0x60, add(input, 0x20), 0x40)
        }
        require(ret);

        assembly {
            ret := staticcall(gas(), 6, add(input, 0x20), 0x80, add(input, 0x60), 0x40)
        }
        require(ret);
    }

    function ecc_mul_add(
        uint256 px,
        uint256 py,
        uint256 s,
        uint256 qx,
        uint256 qy
    ) internal view returns (uint256, uint256) {
        uint256[5] memory input;
        input[0] = px;
        input[1] = py;
        input[2] = s;
        input[3] = qx;
        input[4] = qy;

        _ecc_mul_add(input);

        return (input[3], input[4]);
    }

    function ecc_mul_add_pm(
        uint256[84] memory m,
        uint256[] calldata proof,
        uint256 opcode,
        uint256 t0,
        uint256 t1
    ) internal view returns (uint256, uint256) {
        uint256[5] memory input;
        input[3] = t0;
        input[4] = t1;
        for (uint256 i = 0; i < 32; i += 2) {
            uint256 a = opcode & 0xff;
            if (a != 0xff) {
                opcode >>= 8;
                uint256 b = opcode & 0xff;
                opcode >>= 8;
                input[0] = proof[a];
                input[1] = proof[a + 1];
                input[2] = m[b];
                _ecc_mul_add(input);
            } else {
                break;
            }
        }

        return (input[3], input[4]);
    }

    function update_hash_scalar(
        uint256 v,
        uint256[144] memory absorbing,
        uint256 pos
    ) internal pure {
        absorbing[pos++] = 0x02;
        absorbing[pos++] = v;
    }

    function update_hash_point(
        uint256 x,
        uint256 y,
        uint256[144] memory absorbing,
        uint256 pos
    ) internal pure {
        absorbing[pos++] = 0x01;
        absorbing[pos++] = x;
        absorbing[pos++] = y;
    }

    function to_scalar(bytes32 r) private pure returns (uint256 v) {
        uint256 tmp = uint256(r);
        tmp = fr_reverse(tmp);
        v = tmp % 0x30644e72e131a029b85045b68181585d2833e84879b9709143e1f593f0000001;
    }

    function hash(uint256[144] memory absorbing, uint256 length)
        private
        view
        returns (bytes32[1] memory v)
    {
        bool success;
        assembly {
            success := staticcall(sub(gas(), 2000), 2, absorbing, length, v, 32)
            switch success
            case 0 {
                invalid()
            }
        }
        assert(success);
    }

    function squeeze_challenge(uint256[144] memory absorbing, uint32 length)
        internal
        view
        returns (uint256 v)
    {
        absorbing[length] = 0;
        bytes32 res = hash(absorbing, length * 32 + 1)[0];
        v = to_scalar(res);
        absorbing[0] = uint256(res);
        length = 1;
    }

    function get_verify_circuit_g2_s() internal pure returns (G2Point memory s) {
        s.x[0] = uint256(
            19996377281670978687180986182441301914718493784645870391946826878753710639456
        );
        s.x[1] = uint256(
            4287478848095488335912479212753150961411468232106701703291869721868407715111
        );
        s.y[0] = uint256(
            6995741485533723263267942814565501722132921805029874890336635619836737653877
        );
        s.y[1] = uint256(
            11126659726611658836425410744462014686753643655648740844565393330984713428953
        );
    }

    function get_verify_circuit_g2_n() internal pure returns (G2Point memory n) {
        n.x[0] = uint256(
            11559732032986387107991004021392285783925812861821192530917403151452391805634
        );
        n.x[1] = uint256(
            10857046999023057135944570762232829481370756359578518086990519993285655852781
        );
        n.y[0] = uint256(
            17805874995975841540914202342111839520379459829704422454583296818431106115052
        );
        n.y[1] = uint256(
            13392588948715843804641432497768002650278120570034223513918757245338268106653
        );
    }

    function get_target_circuit_g2_s() internal pure returns (G2Point memory s) {
        s.x[0] = uint256(
            19996377281670978687180986182441301914718493784645870391946826878753710639456
        );
        s.x[1] = uint256(
            4287478848095488335912479212753150961411468232106701703291869721868407715111
        );
        s.y[0] = uint256(
            6995741485533723263267942814565501722132921805029874890336635619836737653877
        );
        s.y[1] = uint256(
            11126659726611658836425410744462014686753643655648740844565393330984713428953
        );
    }

    function get_target_circuit_g2_n() internal pure returns (G2Point memory n) {
        n.x[0] = uint256(
            11559732032986387107991004021392285783925812861821192530917403151452391805634
        );
        n.x[1] = uint256(
            10857046999023057135944570762232829481370756359578518086990519993285655852781
        );
        n.y[0] = uint256(
            17805874995975841540914202342111839520379459829704422454583296818431106115052
        );
        n.y[1] = uint256(
            13392588948715843804641432497768002650278120570034223513918757245338268106653
        );
    }

    function get_wx_wg(uint256[] calldata proof, uint256[6] memory instances)
        internal
        view
        returns (
            uint256,
            uint256,
            uint256,
            uint256
        )
    {
        uint256[84] memory m;
        uint256[144] memory absorbing;
        uint256 t0 = 0;
        uint256 t1 = 0;

        (t0, t1) = (
            ecc_mul(
                16273630658577275004922498653030603356133576819117084202553121866583118864964,
                6490159372778831696763963776713702553449715395136256408127406430701013586737,
                instances[0]
            )
        );
        (t0, t1) = (
            ecc_mul_add(
                21465583338900056601761668793508143213048509206826828900542864688378093593107,
                18916078441896187703473496284050716429170517783995157941513585201547834049281,
                instances[1],
                t0,
                t1
            )
        );
        (t0, t1) = (
            ecc_mul_add(
                6343857336395576108841088300387244434710621968858839561085778033655098739860,
                8647137667680968494319179221347060255241434220013711910139382436020093396308,
                instances[2],
                t0,
                t1
            )
        );
        (t0, t1) = (
            ecc_mul_add(
                17609998990685530094209191702545036897101285294398654477281719279316619940710,
                7891327626892441842954365090016786852185025910332850053066512639794082797200,
                instances[3],
                t0,
                t1
            )
        );
        (t0, t1) = (
            ecc_mul_add(
                1271298011119556361067568041994358027954229594187408866479678256322993207430,
                16519855264988006509000373008036578681979317060055767197977112967887569978562,
                instances[4],
                t0,
                t1
            )
        );
        (m[0], m[1]) = (
            ecc_mul_add(
                9106880861932848269529912338578777683259870408474914617967634470292361865683,
                3191458938194545761508145121615374474619318896841102235687991186359560600763,
                instances[5],
                t0,
                t1
            )
        );
        update_hash_scalar(
            6379018779759029056037780113896287695981871939340391177047336961306062889385,
            absorbing,
            0
        );
        update_hash_point(m[0], m[1], absorbing, 2);
        for (t0 = 0; t0 <= 4; t0++) {
            update_hash_point(proof[0 + t0 * 2], proof[1 + t0 * 2], absorbing, 5 + t0 * 3);
        }
        m[2] = (squeeze_challenge(absorbing, 20));
        for (t0 = 0; t0 <= 13; t0++) {
            update_hash_point(proof[10 + t0 * 2], proof[11 + t0 * 2], absorbing, 1 + t0 * 3);
        }
        m[3] = (squeeze_challenge(absorbing, 43));
        m[4] = (squeeze_challenge(absorbing, 1));
        for (t0 = 0; t0 <= 9; t0++) {
            update_hash_point(proof[38 + t0 * 2], proof[39 + t0 * 2], absorbing, 1 + t0 * 3);
        }
        m[5] = (squeeze_challenge(absorbing, 31));
        for (t0 = 0; t0 <= 3; t0++) {
            update_hash_point(proof[58 + t0 * 2], proof[59 + t0 * 2], absorbing, 1 + t0 * 3);
        }
        m[6] = (squeeze_challenge(absorbing, 13));
        for (t0 = 0; t0 <= 70; t0++) {
            update_hash_scalar(proof[66 + t0 * 1], absorbing, 1 + t0 * 2);
        }
        m[7] = (squeeze_challenge(absorbing, 143));
        for (t0 = 0; t0 <= 3; t0++) {
            update_hash_point(proof[137 + t0 * 2], proof[138 + t0 * 2], absorbing, 1 + t0 * 3);
        }
        m[8] = (squeeze_challenge(absorbing, 13));
        m[9] = (
            mulmod(
                m[6],
                13446667982376394161563610564587413125564757801019538732601045199901075958935,
                q_mod
            )
        );
        m[10] = (
            mulmod(
                m[6],
                16569469942529664681363945218228869388192121720036659574609237682362097667612,
                q_mod
            )
        );
        m[11] = (
            mulmod(
                m[6],
                14803907026430593724305438564799066516271154714737734572920456128449769927233,
                q_mod
            )
        );
        m[12] = (fr_pow(m[6], 67108864));
        m[13] = (addmod(m[12], q_mod - 1, q_mod));
        m[14] = (
            mulmod(
                21888242545679039938882419398440172875981108180010270949818755658014750055173,
                m[13],
                q_mod
            )
        );
        t0 = (addmod(m[6], q_mod - 1, q_mod));
        m[14] = (fr_div(m[14], t0));
        m[15] = (
            mulmod(
                3495999257316610708652455694658595065970881061159015347599790211259094641512,
                m[13],
                q_mod
            )
        );
        t0 = (
            addmod(
                m[6],
                q_mod -
                    14803907026430593724305438564799066516271154714737734572920456128449769927233,
                q_mod
            )
        );
        m[15] = (fr_div(m[15], t0));
        m[16] = (
            mulmod(
                12851378806584061886934576302961450669946047974813165594039554733293326536714,
                m[13],
                q_mod
            )
        );
        t0 = (
            addmod(
                m[6],
                q_mod -
                    11377606117859914088982205826922132024839443553408109299929510653283289974216,
                q_mod
            )
        );
        m[16] = (fr_div(m[16], t0));
        m[17] = (
            mulmod(
                14638077285440018490948843142723135319134576188472316769433007423695824509066,
                m[13],
                q_mod
            )
        );
        t0 = (
            addmod(
                m[6],
                q_mod -
                    3693565015985198455139889557180396682968596245011005461846595820698933079918,
                q_mod
            )
        );
        m[17] = (fr_div(m[17], t0));
        m[18] = (
            mulmod(
                18027939092386982308810165776478549635922357517986691900813373197616541191289,
                m[13],
                q_mod
            )
        );
        t0 = (
            addmod(
                m[6],
                q_mod -
                    17329448237240114492580865744088056414251735686965494637158808787419781175510,
                q_mod
            )
        );
        m[18] = (fr_div(m[18], t0));
        m[19] = (
            mulmod(
                912591536032578604421866340844550116335029274442283291811906603256731601654,
                m[13],
                q_mod
            )
        );
        t0 = (
            addmod(
                m[6],
                q_mod -
                    6047398202650739717314770882059679662647667807426525133977681644606291529311,
                q_mod
            )
        );
        m[19] = (fr_div(m[19], t0));
        m[20] = (
            mulmod(
                17248638560015646562374089181598815896736916575459528793494921668169819478628,
                m[13],
                q_mod
            )
        );
        t0 = (
            addmod(
                m[6],
                q_mod -
                    16569469942529664681363945218228869388192121720036659574609237682362097667612,
                q_mod
            )
        );
        m[20] = (fr_div(m[20], t0));
        t0 = (addmod(m[15], m[16], q_mod));
        t0 = (addmod(t0, m[17], q_mod));
        t0 = (addmod(t0, m[18], q_mod));
        m[15] = (addmod(t0, m[19], q_mod));
        t0 = (fr_mul_add(proof[74], proof[72], proof[73]));
        t0 = (fr_mul_add(proof[75], proof[67], t0));
        t0 = (fr_mul_add(proof[76], proof[68], t0));
        t0 = (fr_mul_add(proof[77], proof[69], t0));
        t0 = (fr_mul_add(proof[78], proof[70], t0));
        m[16] = (fr_mul_add(proof[79], proof[71], t0));
        t0 = (mulmod(proof[67], proof[68], q_mod));
        m[16] = (fr_mul_add(proof[80], t0, m[16]));
        t0 = (mulmod(proof[69], proof[70], q_mod));
        m[16] = (fr_mul_add(proof[81], t0, m[16]));
        t0 = (addmod(1, q_mod - proof[97], q_mod));
        m[17] = (mulmod(m[14], t0, q_mod));
        t0 = (mulmod(proof[100], proof[100], q_mod));
        t0 = (addmod(t0, q_mod - proof[100], q_mod));
        m[18] = (mulmod(m[20], t0, q_mod));
        t0 = (addmod(proof[100], q_mod - proof[99], q_mod));
        m[19] = (mulmod(t0, m[14], q_mod));
        m[21] = (mulmod(m[3], m[6], q_mod));
        t0 = (addmod(m[20], m[15], q_mod));
        m[15] = (addmod(1, q_mod - t0, q_mod));
        m[22] = (addmod(proof[67], m[4], q_mod));
        t0 = (fr_mul_add(proof[91], m[3], m[22]));
        m[23] = (mulmod(t0, proof[98], q_mod));
        t0 = (addmod(m[22], m[21], q_mod));
        m[22] = (mulmod(t0, proof[97], q_mod));
        m[24] = (
            mulmod(
                4131629893567559867359510883348571134090853742863529169391034518566172092834,
                m[21],
                q_mod
            )
        );
        m[25] = (addmod(proof[68], m[4], q_mod));
        t0 = (fr_mul_add(proof[92], m[3], m[25]));
        m[23] = (mulmod(t0, m[23], q_mod));
        t0 = (addmod(m[25], m[24], q_mod));
        m[22] = (mulmod(t0, m[22], q_mod));
        m[24] = (
            mulmod(
                4131629893567559867359510883348571134090853742863529169391034518566172092834,
                m[24],
                q_mod
            )
        );
        m[25] = (addmod(proof[69], m[4], q_mod));
        t0 = (fr_mul_add(proof[93], m[3], m[25]));
        m[23] = (mulmod(t0, m[23], q_mod));
        t0 = (addmod(m[25], m[24], q_mod));
        m[22] = (mulmod(t0, m[22], q_mod));
        m[24] = (
            mulmod(
                4131629893567559867359510883348571134090853742863529169391034518566172092834,
                m[24],
                q_mod
            )
        );
        t0 = (addmod(m[23], q_mod - m[22], q_mod));
        m[22] = (mulmod(t0, m[15], q_mod));
        m[21] = (
            mulmod(
                m[21],
                11166246659983828508719468090013646171463329086121580628794302409516816350802,
                q_mod
            )
        );
        m[23] = (addmod(proof[70], m[4], q_mod));
        t0 = (fr_mul_add(proof[94], m[3], m[23]));
        m[24] = (mulmod(t0, proof[101], q_mod));
        t0 = (addmod(m[23], m[21], q_mod));
        m[23] = (mulmod(t0, proof[100], q_mod));
        m[21] = (
            mulmod(
                4131629893567559867359510883348571134090853742863529169391034518566172092834,
                m[21],
                q_mod
            )
        );
        m[25] = (addmod(proof[71], m[4], q_mod));
        t0 = (fr_mul_add(proof[95], m[3], m[25]));
        m[24] = (mulmod(t0, m[24], q_mod));
        t0 = (addmod(m[25], m[21], q_mod));
        m[23] = (mulmod(t0, m[23], q_mod));
        m[21] = (
            mulmod(
                4131629893567559867359510883348571134090853742863529169391034518566172092834,
                m[21],
                q_mod
            )
        );
        m[25] = (addmod(proof[66], m[4], q_mod));
        t0 = (fr_mul_add(proof[96], m[3], m[25]));
        m[24] = (mulmod(t0, m[24], q_mod));
        t0 = (addmod(m[25], m[21], q_mod));
        m[23] = (mulmod(t0, m[23], q_mod));
        m[21] = (
            mulmod(
                4131629893567559867359510883348571134090853742863529169391034518566172092834,
                m[21],
                q_mod
            )
        );
        t0 = (addmod(m[24], q_mod - m[23], q_mod));
        m[21] = (mulmod(t0, m[15], q_mod));
        t0 = (addmod(proof[104], m[3], q_mod));
        m[23] = (mulmod(proof[103], t0, q_mod));
        t0 = (addmod(proof[106], m[4], q_mod));
        m[23] = (mulmod(m[23], t0, q_mod));
        m[24] = (mulmod(proof[67], proof[82], q_mod));
        m[2] = (mulmod(0, m[2], q_mod));
        m[24] = (addmod(m[2], m[24], q_mod));
        m[25] = (addmod(m[2], proof[83], q_mod));
        m[26] = (addmod(proof[104], q_mod - proof[106], q_mod));
        t0 = (addmod(1, q_mod - proof[102], q_mod));
        m[27] = (mulmod(m[14], t0, q_mod));
        t0 = (mulmod(proof[102], proof[102], q_mod));
        t0 = (addmod(t0, q_mod - proof[102], q_mod));
        m[28] = (mulmod(m[20], t0, q_mod));
        t0 = (addmod(m[24], m[3], q_mod));
        m[24] = (mulmod(proof[102], t0, q_mod));
        m[25] = (addmod(m[25], m[4], q_mod));
        t0 = (mulmod(m[24], m[25], q_mod));
        t0 = (addmod(m[23], q_mod - t0, q_mod));
        m[23] = (mulmod(t0, m[15], q_mod));
        m[24] = (mulmod(m[14], m[26], q_mod));
        t0 = (addmod(proof[104], q_mod - proof[105], q_mod));
        t0 = (mulmod(m[26], t0, q_mod));
        m[26] = (mulmod(t0, m[15], q_mod));
        t0 = (addmod(proof[109], m[3], q_mod));
        m[29] = (mulmod(proof[108], t0, q_mod));
        t0 = (addmod(proof[111], m[4], q_mod));
        m[29] = (mulmod(m[29], t0, q_mod));
        m[30] = (fr_mul_add(proof[82], proof[68], m[2]));
        m[31] = (addmod(proof[109], q_mod - proof[111], q_mod));
        t0 = (addmod(1, q_mod - proof[107], q_mod));
        m[32] = (mulmod(m[14], t0, q_mod));
        t0 = (mulmod(proof[107], proof[107], q_mod));
        t0 = (addmod(t0, q_mod - proof[107], q_mod));
        m[33] = (mulmod(m[20], t0, q_mod));
        t0 = (addmod(m[30], m[3], q_mod));
        t0 = (mulmod(proof[107], t0, q_mod));
        t0 = (mulmod(t0, m[25], q_mod));
        t0 = (addmod(m[29], q_mod - t0, q_mod));
        m[29] = (mulmod(t0, m[15], q_mod));
        m[30] = (mulmod(m[14], m[31], q_mod));
        t0 = (addmod(proof[109], q_mod - proof[110], q_mod));
        t0 = (mulmod(m[31], t0, q_mod));
        m[31] = (mulmod(t0, m[15], q_mod));
        t0 = (addmod(proof[114], m[3], q_mod));
        m[34] = (mulmod(proof[113], t0, q_mod));
        t0 = (addmod(proof[116], m[4], q_mod));
        m[34] = (mulmod(m[34], t0, q_mod));
        m[35] = (fr_mul_add(proof[82], proof[69], m[2]));
        m[36] = (addmod(proof[114], q_mod - proof[116], q_mod));
        t0 = (addmod(1, q_mod - proof[112], q_mod));
        m[37] = (mulmod(m[14], t0, q_mod));
        t0 = (mulmod(proof[112], proof[112], q_mod));
        t0 = (addmod(t0, q_mod - proof[112], q_mod));
        m[38] = (mulmod(m[20], t0, q_mod));
        t0 = (addmod(m[35], m[3], q_mod));
        t0 = (mulmod(proof[112], t0, q_mod));
        t0 = (mulmod(t0, m[25], q_mod));
        t0 = (addmod(m[34], q_mod - t0, q_mod));
        m[34] = (mulmod(t0, m[15], q_mod));
        m[35] = (mulmod(m[14], m[36], q_mod));
        t0 = (addmod(proof[114], q_mod - proof[115], q_mod));
        t0 = (mulmod(m[36], t0, q_mod));
        m[36] = (mulmod(t0, m[15], q_mod));
        t0 = (addmod(proof[119], m[3], q_mod));
        m[39] = (mulmod(proof[118], t0, q_mod));
        t0 = (addmod(proof[121], m[4], q_mod));
        m[39] = (mulmod(m[39], t0, q_mod));
        m[40] = (fr_mul_add(proof[82], proof[70], m[2]));
        m[41] = (addmod(proof[119], q_mod - proof[121], q_mod));
        t0 = (addmod(1, q_mod - proof[117], q_mod));
        m[42] = (mulmod(m[14], t0, q_mod));
        t0 = (mulmod(proof[117], proof[117], q_mod));
        t0 = (addmod(t0, q_mod - proof[117], q_mod));
        m[43] = (mulmod(m[20], t0, q_mod));
        t0 = (addmod(m[40], m[3], q_mod));
        t0 = (mulmod(proof[117], t0, q_mod));
        t0 = (mulmod(t0, m[25], q_mod));
        t0 = (addmod(m[39], q_mod - t0, q_mod));
        m[25] = (mulmod(t0, m[15], q_mod));
        m[39] = (mulmod(m[14], m[41], q_mod));
        t0 = (addmod(proof[119], q_mod - proof[120], q_mod));
        t0 = (mulmod(m[41], t0, q_mod));
        m[40] = (mulmod(t0, m[15], q_mod));
        t0 = (addmod(proof[124], m[3], q_mod));
        m[41] = (mulmod(proof[123], t0, q_mod));
        t0 = (addmod(proof[126], m[4], q_mod));
        m[41] = (mulmod(m[41], t0, q_mod));
        m[44] = (fr_mul_add(proof[84], proof[67], m[2]));
        m[45] = (addmod(m[2], proof[85], q_mod));
        m[46] = (addmod(proof[124], q_mod - proof[126], q_mod));
        t0 = (addmod(1, q_mod - proof[122], q_mod));
        m[47] = (mulmod(m[14], t0, q_mod));
        t0 = (mulmod(proof[122], proof[122], q_mod));
        t0 = (addmod(t0, q_mod - proof[122], q_mod));
        m[48] = (mulmod(m[20], t0, q_mod));
        t0 = (addmod(m[44], m[3], q_mod));
        m[44] = (mulmod(proof[122], t0, q_mod));
        t0 = (addmod(m[45], m[4], q_mod));
        t0 = (mulmod(m[44], t0, q_mod));
        t0 = (addmod(m[41], q_mod - t0, q_mod));
        m[41] = (mulmod(t0, m[15], q_mod));
        m[44] = (mulmod(m[14], m[46], q_mod));
        t0 = (addmod(proof[124], q_mod - proof[125], q_mod));
        t0 = (mulmod(m[46], t0, q_mod));
        m[45] = (mulmod(t0, m[15], q_mod));
        t0 = (addmod(proof[129], m[3], q_mod));
        m[46] = (mulmod(proof[128], t0, q_mod));
        t0 = (addmod(proof[131], m[4], q_mod));
        m[46] = (mulmod(m[46], t0, q_mod));
        m[49] = (fr_mul_add(proof[86], proof[67], m[2]));
        m[50] = (addmod(m[2], proof[87], q_mod));
        m[51] = (addmod(proof[129], q_mod - proof[131], q_mod));
        t0 = (addmod(1, q_mod - proof[127], q_mod));
        m[52] = (mulmod(m[14], t0, q_mod));
        t0 = (mulmod(proof[127], proof[127], q_mod));
        t0 = (addmod(t0, q_mod - proof[127], q_mod));
        m[53] = (mulmod(m[20], t0, q_mod));
        t0 = (addmod(m[49], m[3], q_mod));
        m[49] = (mulmod(proof[127], t0, q_mod));
        t0 = (addmod(m[50], m[4], q_mod));
        t0 = (mulmod(m[49], t0, q_mod));
        t0 = (addmod(m[46], q_mod - t0, q_mod));
        m[46] = (mulmod(t0, m[15], q_mod));
        m[49] = (mulmod(m[14], m[51], q_mod));
        t0 = (addmod(proof[129], q_mod - proof[130], q_mod));
        t0 = (mulmod(m[51], t0, q_mod));
        m[50] = (mulmod(t0, m[15], q_mod));
        t0 = (addmod(proof[134], m[3], q_mod));
        m[51] = (mulmod(proof[133], t0, q_mod));
        t0 = (addmod(proof[136], m[4], q_mod));
        m[51] = (mulmod(m[51], t0, q_mod));
        m[54] = (fr_mul_add(proof[88], proof[67], m[2]));
        m[2] = (addmod(m[2], proof[89], q_mod));
        m[55] = (addmod(proof[134], q_mod - proof[136], q_mod));
        t0 = (addmod(1, q_mod - proof[132], q_mod));
        m[56] = (mulmod(m[14], t0, q_mod));
        t0 = (mulmod(proof[132], proof[132], q_mod));
        t0 = (addmod(t0, q_mod - proof[132], q_mod));
        m[20] = (mulmod(m[20], t0, q_mod));
        t0 = (addmod(m[54], m[3], q_mod));
        m[3] = (mulmod(proof[132], t0, q_mod));
        t0 = (addmod(m[2], m[4], q_mod));
        t0 = (mulmod(m[3], t0, q_mod));
        t0 = (addmod(m[51], q_mod - t0, q_mod));
        m[2] = (mulmod(t0, m[15], q_mod));
        m[3] = (mulmod(m[14], m[55], q_mod));
        t0 = (addmod(proof[134], q_mod - proof[135], q_mod));
        t0 = (mulmod(m[55], t0, q_mod));
        m[4] = (mulmod(t0, m[15], q_mod));
        t0 = (fr_mul_add(m[5], 0, m[16]));
        t0 = (
            fr_mul_add_mt(
                m,
                m[5],
                24064768791442479290152634096194013545513974547709823832001394403118888981009,
                t0
            )
        );
        t0 = (fr_mul_add_mt(m, m[5], 4704208815882882920750, t0));
        m[2] = (fr_div(t0, m[13]));
        m[3] = (mulmod(m[8], m[8], q_mod));
        m[4] = (mulmod(m[3], m[8], q_mod));
        (t0, t1) = (ecc_mul(proof[143], proof[144], m[4]));
        (t0, t1) = (ecc_mul_add_pm(m, proof, 281470825071501, t0, t1));
        (m[14], m[15]) = (ecc_add(t0, t1, proof[137], proof[138]));
        m[5] = (mulmod(m[4], m[11], q_mod));
        m[11] = (mulmod(m[4], m[7], q_mod));
        m[13] = (mulmod(m[11], m[7], q_mod));
        m[16] = (mulmod(m[13], m[7], q_mod));
        m[17] = (mulmod(m[16], m[7], q_mod));
        m[18] = (mulmod(m[17], m[7], q_mod));
        m[19] = (mulmod(m[18], m[7], q_mod));
        t0 = (mulmod(m[19], proof[135], q_mod));
        t0 = (fr_mul_add_pm(m, proof, 79227007564587019091207590530, t0));
        m[20] = (fr_mul_add(proof[105], m[4], t0));
        m[10] = (mulmod(m[3], m[10], q_mod));
        m[20] = (fr_mul_add(proof[99], m[3], m[20]));
        m[9] = (mulmod(m[8], m[9], q_mod));
        m[21] = (mulmod(m[8], m[7], q_mod));
        for (t0 = 0; t0 < 8; t0++) {
            m[22 + t0 * 1] = (mulmod(m[21 + t0 * 1], m[7 + t0 * 0], q_mod));
        }
        t0 = (mulmod(m[29], proof[133], q_mod));
        t0 = (fr_mul_add_pm(m, proof, 1461480058012745347196003969984389955172320353408, t0));
        m[20] = (addmod(m[20], t0, q_mod));
        m[3] = (addmod(m[3], m[21], q_mod));
        m[21] = (mulmod(m[7], m[7], q_mod));
        m[30] = (mulmod(m[21], m[7], q_mod));
        for (t0 = 0; t0 < 50; t0++) {
            m[31 + t0 * 1] = (mulmod(m[30 + t0 * 1], m[7 + t0 * 0], q_mod));
        }
        m[81] = (mulmod(m[80], proof[90], q_mod));
        m[82] = (mulmod(m[79], m[12], q_mod));
        m[83] = (mulmod(m[82], m[12], q_mod));
        m[12] = (mulmod(m[83], m[12], q_mod));
        t0 = (fr_mul_add(m[79], m[2], m[81]));
        t0 = (
            fr_mul_add_pm(
                m,
                proof,
                28637501128329066231612878461967933875285131620580756137874852300330784214624,
                t0
            )
        );
        t0 = (
            fr_mul_add_pm(
                m,
                proof,
                21474593857386732646168474467085622855647258609351047587832868301163767676495,
                t0
            )
        );
        t0 = (
            fr_mul_add_pm(
                m,
                proof,
                14145600374170319983429588659751245017860232382696106927048396310641433325177,
                t0
            )
        );
        t0 = (fr_mul_add_pm(m, proof, 18446470583433829957, t0));
        t0 = (addmod(t0, proof[66], q_mod));
        m[2] = (addmod(m[20], t0, q_mod));
        m[19] = (addmod(m[19], m[54], q_mod));
        m[20] = (addmod(m[29], m[53], q_mod));
        m[18] = (addmod(m[18], m[51], q_mod));
        m[28] = (addmod(m[28], m[50], q_mod));
        m[17] = (addmod(m[17], m[48], q_mod));
        m[27] = (addmod(m[27], m[47], q_mod));
        m[16] = (addmod(m[16], m[45], q_mod));
        m[26] = (addmod(m[26], m[44], q_mod));
        m[13] = (addmod(m[13], m[42], q_mod));
        m[25] = (addmod(m[25], m[41], q_mod));
        m[11] = (addmod(m[11], m[39], q_mod));
        m[24] = (addmod(m[24], m[38], q_mod));
        m[4] = (addmod(m[4], m[36], q_mod));
        m[23] = (addmod(m[23], m[35], q_mod));
        m[22] = (addmod(m[22], m[34], q_mod));
        m[3] = (addmod(m[3], m[33], q_mod));
        m[8] = (addmod(m[8], m[32], q_mod));
        (t0, t1) = (ecc_mul(proof[143], proof[144], m[5]));
        (t0, t1) = (
            ecc_mul_add_pm(
                m,
                proof,
                10933423423422768024429730621579321771439401845242250760130969989159573132066,
                t0,
                t1
            )
        );
        (t0, t1) = (
            ecc_mul_add_pm(m, proof, 1461486238301980199876269201563775120819706402602, t0, t1)
        );
        (t0, t1) = (
            ecc_mul_add(
                6589042455668774993548507622769862285097961288861605118774278282921268707251,
                18435101895615810811355111166113359640558281288483679649225840799456081235368,
                m[78],
                t0,
                t1
            )
        );
        (t0, t1) = (
            ecc_mul_add(
                9445948199482418748804034927510368323528750238880939954671311541418422118311,
                19708330365646306624915766743842802206021168263909542838040952565683812632935,
                m[77],
                t0,
                t1
            )
        );
        (t0, t1) = (
            ecc_mul_add(
                2041955400656973497586273104094179931771685168425328919510494675244451879615,
                5333373224207353798604834135311751466096835377411390360085597734141319499247,
                m[76],
                t0,
                t1
            )
        );
        (t0, t1) = (
            ecc_mul_add(
                7131747301335983133581280966503113285909583428240951198690237273104499759678,
                9288903034373424489679815523932851713536899155773917979984650008455728254647,
                m[75],
                t0,
                t1
            )
        );
        (t0, t1) = (
            ecc_mul_add(
                15471578256339132853118624775656562117744540161736344242893916526566368757794,
                11784153007614907378372094763990325238343098848133342312823248866847184827181,
                m[74],
                t0,
                t1
            )
        );
        (t0, t1) = (
            ecc_mul_add(
                7672670645119534310699028366232766458320746173988728759566235182121543592274,
                15733076186569356731477150765264698283661439667774795602891045798502430440270,
                m[73],
                t0,
                t1
            )
        );
        (t0, t1) = (
            ecc_mul_add(
                5422170891120229182360564594866246906567981360038071999127508208070564034524,
                14722029885921976755274052080011416898514630484317773275415621146460924728182,
                m[72],
                t0,
                t1
            )
        );
        (t0, t1) = (
            ecc_mul_add(
                12051701340523772065226815921632231217476696511520888118096773077045674552867,
                19980067035105742769408236073160470824975998174266323284806160180674624248635,
                m[71],
                t0,
                t1
            )
        );
        (t0, t1) = (
            ecc_mul_add(
                18451207565454686459225553564649439057698581050443267052774483067774590965003,
                4419693978684087696088612463773850574955779922948673330581664932100506990694,
                m[70],
                t0,
                t1
            )
        );
        (t0, t1) = (
            ecc_mul_add(
                13410360497295965053469811324659619242082272118328557995283785892368870296159,
                836817334786967541636324043429354480712244201049522947424613386674907898982,
                m[69],
                t0,
                t1
            )
        );
        (t0, t1) = (
            ecc_mul_add(
                5422170891120229182360564594866246906567981360038071999127508208070564034524,
                14722029885921976755274052080011416898514630484317773275415621146460924728182,
                m[68],
                t0,
                t1
            )
        );
        (t0, t1) = (
            ecc_mul_add(
                15901961656218341611659303365222972292163356939816420955485065177188980021591,
                150069089331948899349247014368821682640743294515553006810730694835466432424,
                m[67],
                t0,
                t1
            )
        );
        (t0, t1) = (
            ecc_mul_add(
                21537162186981550637121053147454964150809482185492418377558290311964245821909,
                2173324946696678910860567153502925685634606622474439126082176533839311460335,
                m[66],
                t0,
                t1
            )
        );
        (t0, t1) = (
            ecc_mul_add(
                14209203445645693011290491458340191904486781536312282145260937041500277051629,
                8938693903172693640318384152472672459954100557223397554055870768585614251246,
                m[65],
                t0,
                t1
            )
        );
        (t0, t1) = (
            ecc_mul_add(
                10393978979654596932096477739070904298026830278065192254800442231342712320069,
                15547680557153687682315775217900343666069651501633242517805884367299314601133,
                m[64],
                t0,
                t1
            )
        );
        (t0, t1) = (
            ecc_mul_add(
                21420907296100121657506044584758704529488801561169619133255509566227010857019,
                16707116651855905310667647644578456917745502322542888020598386582586965360377,
                m[63],
                t0,
                t1
            )
        );
        (t0, t1) = (
            ecc_mul_add(
                9752678269855553358875574239430158995166231910644640610084257674739663109348,
                16124964834303000168033111893524199690467578616798095865296650850545879741103,
                m[62],
                t0,
                t1
            )
        );
        (t0, t1) = (
            ecc_mul_add(
                20733615319443758674319653312263451192420067621042495277401644023716901919068,
                1830207051243189057408806955361847859760252002553128109177854875759113246138,
                m[61],
                t0,
                t1
            )
        );
        (t0, t1) = (
            ecc_mul_add(
                10729649377634468297898556510782347615440385427433820828410908159850572202683,
                18944755247517785161232746176620844901070168742703477675372601145512629220665,
                m[60],
                t0,
                t1
            )
        );
        (t0, t1) = (
            ecc_mul_add(
                17262150684904605079118770315408423395873388001673600221385636008654454685127,
                7379438282859956297547691979050576544843120316657837112711440332925029516679,
                m[59],
                t0,
                t1
            )
        );
        (t0, t1) = (
            ecc_mul_add(
                12650924717928384809087061743117166474820344796186926704663329550256588420525,
                2762681788476863882672689428048029790917207836534743642827703719844509404807,
                m[58],
                t0,
                t1
            )
        );
        (t0, t1) = (
            ecc_mul_add(
                1650178369565540665684670280181396655204386828631957099338336529585959509775,
                7294134148082654375463760839797575225864173067090223959616193674934475927004,
                m[57],
                t0,
                t1
            )
        );
        (t0, t1) = (
            ecc_mul_add(
                21706920605803128160070229702245547885879925471126791674838189216481018995041,
                7838090009018403737838743168493566122906246805438028736347896156955552534066,
                m[56],
                t0,
                t1
            )
        );
        (t0, t1) = (
            ecc_mul_add_pm(
                m,
                proof,
                6277008573546246765208814532330797927747086570010716419876,
                t0,
                t1
            )
        );
        (m[0], m[1]) = (ecc_add(t0, t1, m[0], m[1]));
        (t0, t1) = (ecc_mul(1, 2, m[2]));
        (m[0], m[1]) = (ecc_sub(m[0], m[1], t0, t1));
        return (m[14], m[15], m[0], m[1]);
    }

    function verify(
        uint256[] calldata proof,
        uint256[] calldata target_circuit_final_pair,
        bytes32 publicInputHash
    ) public view returns (bool) {
        uint256[6] memory instances;
        instances[0] = target_circuit_final_pair[0] & ((1 << 136) - 1);
        instances[1] =
            (target_circuit_final_pair[0] >> 136) +
            ((target_circuit_final_pair[1] & 1) << 136);
        instances[2] = target_circuit_final_pair[2] & ((1 << 136) - 1);
        instances[3] =
            (target_circuit_final_pair[2] >> 136) +
            ((target_circuit_final_pair[3] & 1) << 136);

        instances[4] = uint256(publicInputHash) >> (8 * 16);
        instances[5] = uint256(publicInputHash) & uint256(2**128 - 1);

        uint256 x0 = 0;
        uint256 x1 = 0;
        uint256 y0 = 0;
        uint256 y1 = 0;

        G1Point[] memory g1_points = new G1Point[](2);
        G2Point[] memory g2_points = new G2Point[](2);

        (x0, y0, x1, y1) = get_wx_wg(proof, instances);
        g1_points[0].x = x0;
        g1_points[0].y = y0;
        g1_points[1].x = x1;
        g1_points[1].y = y1;
        g2_points[0] = get_verify_circuit_g2_s();
        g2_points[1] = get_verify_circuit_g2_n();

        if (!pairing(g1_points, g2_points)) {
            return false;
        }

        g1_points[0].x = target_circuit_final_pair[0];
        g1_points[0].y = target_circuit_final_pair[1];
        g1_points[1].x = target_circuit_final_pair[2];
        g1_points[1].y = target_circuit_final_pair[3];
        g2_points[0] = get_target_circuit_g2_s();
        g2_points[1] = get_target_circuit_g2_n();

        if (!pairing(g1_points, g2_points)) {
            return false;
        }

        return true;
    }
}
