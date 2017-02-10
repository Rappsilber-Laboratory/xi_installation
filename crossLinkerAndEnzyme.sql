--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: crosslinker; Type: TABLE; Schema: public; Owner: myXi3_user; Tablespace:
--

CREATE TABLE crosslinker (
    id integer NOT NULL,
    name character varying(100),
    mass character varying(100),
    is_decoy boolean DEFAULT false,
    description text,
    is_default boolean
);


ALTER TABLE crosslinker OWNER TO myXi3_user;

--
-- Name: COLUMN crosslinker.is_default; Type: COMMENT; Schema: public; Owner: myXi3_user
--

COMMENT ON COLUMN crosslinker.is_default IS 'Should the crosslinker be selected by default?';


--
-- Name: crosslinker_id_seq; Type: SEQUENCE; Schema: public; Owner: myXi3_user
--

CREATE SEQUENCE crosslinker_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE crosslinker_id_seq OWNER TO myXi3_user;

--
-- Name: crosslinker_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: myXi3_user
--

ALTER SEQUENCE crosslinker_id_seq OWNED BY crosslinker.id;


--
-- Name: enzyme; Type: TABLE; Schema: public; Owner: myXi3_user; Tablespace:
--

CREATE TABLE enzyme (
    id integer NOT NULL,
    name character varying(100),
    description text,
    is_default boolean
);


ALTER TABLE enzyme OWNER TO myXi3_user;

--
-- Name: COLUMN enzyme.is_default; Type: COMMENT; Schema: public; Owner: myXi3_user
--

COMMENT ON COLUMN enzyme.is_default IS 'Is the enzyme selected by default?';


--
-- Name: enzyme_id_seq; Type: SEQUENCE; Schema: public; Owner: myXi3_user
--

CREATE SEQUENCE enzyme_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE enzyme_id_seq OWNER TO myXi3_user;

--
-- Name: enzyme_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: myXi3_user
--

ALTER SEQUENCE enzyme_id_seq OWNED BY enzyme.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: myXi3_user
--

ALTER TABLE ONLY crosslinker ALTER COLUMN id SET DEFAULT nextval('crosslinker_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: myXi3_user
--

ALTER TABLE ONLY enzyme ALTER COLUMN id SET DEFAULT nextval('enzyme_id_seq'::regclass);


--
-- Data for Name: crosslinker; Type: TABLE DATA; Schema: public; Owner: myXi3_user
--

COPY crosslinker (id, name, mass, is_decoy, description, is_default) FROM stdin;
1   BS2G    96.02112055 f   crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:BS2G;MASS:96.02112055;LINKEDAMINOACIDS:K,S,T,Y,nterm  \N
3   XL9 403.137950  f   crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:XL9;MASS:403.137950;LINKEDAMINOACIDS:K,S,T,Y,nterm    \N
4   XL10    402.142701  f   crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:XL10;MASS:402.142701;LINKEDAMINOACIDS:K,S,T,Y,nterm   \N
9   BS2G (K only)   96.02112055 f   crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:BS2G;MASS:96.02112055;LINKEDAMINOACIDS:K,nterm    \N
2   BS3 138.06807961    f   crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:BS3;MASS:138.06807961;LINKEDAMINOACIDS:K(0),S(0.2),T(0.2),Y(0.2),nterm(0) \N
7   BS3+NH+OH+INTERNAL  138.06807   f   crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:BS3;MASS:138.06807961;LINKEDAMINOACIDS:K(0),S(0.2),T(0.2),Y(0.2),nterm(0);MODIFICATIONS:NH2,17.026549105,OH,18.0105647,LOOP,0 \N
5   EDC -18.01056027    f   crosslinker:AsymetricSingleAminoAcidRestrictedCrossLinker:Name:EDC;MASS:-18.01056027;FIRSTLINKEDAMINOACIDS:E,D,Nda,Qda,cterm;SECONDLINKEDAMINOACIDS:K,S,Y,T,nterm   \N
12  EDC (N,Q -17)   -17.0260005250906   f   crosslinker:AsymetricSingleAminoAcidRestrictedCrossLinker:Name:EDC;MASS:-17.0260005250906;FIRSTLINKEDAMINOACIDS:N,Q,cterm;SECONDLINKEDAMINOACIDS:K,S,Y,T,nterm  \N
15  BS3 (K only)    138.06807   f   crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:BS3;MASS:138.06807961;LINKEDAMINOACIDS:K(0),nterm(0); \N
6   BS(PEG)5    302.13655   f   crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:BS(PEG)5;MASS:302.13655;LINKEDAMINOACIDS:K(0),S(0.2),T(0.2),Y(0.2),nterm(0)   \N
26  TargetModification  0   f   crosslinker:DummyCrosslinker:Name:TargetModification    \N
8   BS3+NH+OH   138.06807   f   crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:BS3;MASS:138.06807961;LINKEDAMINOACIDS:K(0),S(0.2),T(0.2),Y(0.2),nterm(0);MODIFICATIONS:NH2,17.026549105,OH,18.0105647    \N
10  BS3-d4  142.0931769836  f   crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:BS3-d4;MASS:142.0931769836;LINKEDAMINOACIDS:K(0),S(0.2),T(0.2),Y(0.2),nterm(0)    \N
16  BS3(K4K6K8STY)  138.06807   f   crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:BS3;MASS:138.06807961;LINKEDAMINOACIDS:K(0),K8(0),K4(0),K6(0),S(0.2),T(0.2),Y(0.2),nterm(0);MODIFICATIONS:NH2,17.026549105,OH,18.0105647,LOOP,0   \N
17  OpenModification    0   f   crosslinker:DummyCrosslinker:Name:OpenModification  \N
11  BS3-d4+OH+NH2+loop  142.0931769836  f   crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:BS3-d4;MASS:142.0931769836;LINKEDAMINOACIDS:K(0),S(0.2),T(0.2),Y(0.2),nterm(0);MODIFICATIONS:NH2,17.026549105,OH,18.0105647,LOOP,0    \N
18  BS3-d4+OH+NH2   142.0931769836  f   crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:BS3-d4;MASS:142.0931769836;LINKEDAMINOACIDS:K(0),S(0.2),T(0.2),Y(0.2),nterm(0);MODIFICATIONS:NH2,17.026549105,OH,18.0105647   \N
23  BS3 (K) +NH+OH  138.06807   f   crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:BS3;MASS:138.06807961;LINKEDAMINOACIDS:K(0),nterm(0);MODIFICATIONS:NH2,17.026549105,OH,18.0105647 \N
24  EGS (KSTY)+NH2+OH   226.047738  f   crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:EGS;MASS:226.047738;LINKEDAMINOACIDS:K(0),S(0.2),T(0.2),Y(0.2),nterm(0);MODIFICATIONS:NH2,17.026549105,OH,18.0105647  \N
25  BS2G (KSTY) (NH2 OH)    96.02112055 f   crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:BS2G;MASS:96.02112055;LINKEDAMINOACIDS:K(0),S(0.2),T(0.2),Y(0.2),nterm(0);MODIFICATIONS:NH2,17.026549105,OH,18.0105647    \N
29  LC-SDA  195.125928855   f   crosslinker:AsymetricSingleAminoAcidRestrictedCrossLinker:Name:LC-SDA;MASS:195.125928855;FIRSTLINKEDAMINOACIDS:R,H,K,D,E,S,T,N,Q,C,U,G,P,A,V,I,L,M,F,Y,W;SECONDLINKEDAMINOACIDS:K,S,Y,T,nterm   \N
27  Tyr Any -2H -2.01565007 f   crosslinker:AsymetricSingleAminoAcidRestrictedCrossLinker:Name:Tyr-2H;MASS:-2.01565007;FIRSTLINKEDAMINOACIDS:R,H,K,D,E,S,T,N,Q,C,U,G,P,A,V,I,L,M,F,Y,W;SECONDLINKEDAMINOACIDS:Y \N
28  -2H -2.01565007 f   crosslinker:AsymetricSingleAminoAcidRestrictedCrossLinker:Name:Tyr-2H;MASS:-2.01565007;FIRSTLINKEDAMINOACIDS:R,H,K,D,E,S,T,N,Q,C,U,G,P,A,V,I,L,M,F,Y,W;SECONDLINKEDAMINOACIDS:R,H,K,D,E,S,T,N,Q,C,U,G,P,A,V,I,L,M,F,Y,W \N
30  -1H -1.007825   f   crosslinker:AsymetricSingleAminoAcidRestrictedCrossLinker:Name:Tyr-1H;MASS:-1.007825;FIRSTLINKEDAMINOACIDS:R,H,K,D,E,S,T,N,Q,C,U,G,P,A,V,I,L,M,F,Y,W;SECONDLINKEDAMINOACIDS:R,H,K,D,E,S,T,N,Q,C,U,G,P,A,V,I,L,M,F,Y,W   \N
34  DECOY BS2G (KSTY)   96.02112055 t   crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:BS2G;MASS:96.02112055;LINKEDAMINOACIDS:K(0),S(0.2),T(0.2),Y(0.2),nterm(0);    \N
31  -3H -3.023475   f   crosslinker:AsymetricSingleAminoAcidRestrictedCrossLinker:Name:Tyr-3H;MASS:-3.023475;FIRSTLINKEDAMINOACIDS:R,H,K,D,E,S,T,N,Q,C,U,G,P,A,V,I,L,M,F,Y,W;SECONDLINKEDAMINOACIDS:R,H,K,D,E,S,T,N,Q,C,U,G,P,A,V,I,L,M,F,Y,W   \N
32  -OH -17.002740  f   crosslinker:AsymetricSingleAminoAcidRestrictedCrossLinker:Name:Tyr-OH;MASS:-17.002740;FIRSTLINKEDAMINOACIDS:R,H,K,D,E,S,T,N,Q,C,U,G,P,A,V,I,L,M,F,Y,W;SECONDLINKEDAMINOACIDS:R,H,K,D,E,S,T,N,Q,C,U,G,P,A,V,I,L,M,F,Y,W  \N
14  BS3+NH+OH   138.06807   f   crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:BS3;MASS:138.06807961;LINKEDAMINOACIDS:K(0),S(0.2),T(0.2),Y(0.2),nterm(0);MODIFICATIONS:NH2,17.026549105,OH,18.0105647    t
38  BENZO (C14H8O2) 208.052430  f   crosslinker:AsymetricSingleAminoAcidRestrictedCrossLinker:Name:BENZO;MASS:208.052430;FIRSTLINKEDAMINOACIDS:R,H,K,D,E,S,T,N,Q,C,U,G,P,A,V,I,L,M,F,Y,W,K8,Ccm,Mox;SECONDLINKEDAMINOACIDS:K,S,Y,T,K8,nterm \N
46  BPM 277.073894  f   crosslinker:AsymetricSingleAminoAcidRestrictedCrossLinker:Name:BPM;MASS:277.073894;FIRSTLINKEDAMINOACIDS:R,H,K,D,E,S,T,N,Q,C,U,G,P,A,V,I,L,M,F,Y,W,Mox,Ccm;SECONDLINKEDAMINOACIDS:C \N
37  DECOY BS3 - Ala 67.03096    t   crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:BS3;MASS:67.03096;LINKEDAMINOACIDS:K(0),S(0.2),T(0.2),Y(0.2),nterm(0) \N
36  DECOY BS3 - Gly 81.04661    t   crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:BS3;MASS:81.04661;LINKEDAMINOACIDS:K(0),S(0.2),T(0.2),Y(0.2),nterm(0) \N
35  DECOY BS3 - 30Da    108.06807   t   crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:BS3;MASS:108.06807961;LINKEDAMINOACIDS:K(0),S(0.2),T(0.2),Y(0.2),nterm(0) \N
40  Photo-Methionine    -19.972072  f   crosslinker:AsymetricSingleAminoAcidRestrictedCrossLinker:Name:Photo-Methionine;MASS:-19.972072;FIRSTLINKEDAMINOACIDS:Ccm,Mox,R,H,K,D,E,S,T,N,Q,C,U,G,P,A,V,I,L,M,F,Y,W;SECONDLINKEDAMINOACIDS:M    \N
41  DASD-BS3-like   365.998031  f   crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:DASD-BS3-like;MASS:365.998031;LINKEDAMINOACIDS:K(0),S(0.2),T(0.2),Y(0.2),nterm(0) \N
42  DASD-non-specfific  365.998031  f   crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:DASD-non-specfific;MASS:365.998031;LINKEDAMINOACIDS:R,H,K,D,E,S,T,N,Q,C,U,G,P,A,V,I,L,M,F,Y,W \N
47  Tyr Tyr -2H -2.01565007 f   crosslinker:AsymetricSingleAminoAcidRestrictedCrossLinker:Name:Tyr-2H;MASS:-2.01565007;FIRSTLINKEDAMINOACIDS:Y;SECONDLINKEDAMINOACIDS:Y \N
44  BSOCOES+NH+OH   205.988512  f   crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:BSOCOES;MASS:205.988512;LINKEDAMINOACIDS:K(0),S(0.2),T(0.2),Y(0.2),nterm(0);MODIFICATIONS:NH2,17.026549105,OH,18.0105647  \N
43  TSAT+NH+OH  137.093196  f   crosslinker:SymetricNarrySingleAminoAcidRestrictedCrossLinker:Name:TSAT;MASS:137.011294;LINKEDAMINOACIDS:K(0),S(0.2),T(0.2),Y(0.2),nterm(0);MODIFICATIONS:NH2,17.026549105,OH,18.0105647;MOIETIES:3 \N
45  DST+NH+OH   113.995310  f   crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:DST;MASS:113.995310;LINKEDAMINOACIDS:K(0),S(0.2),T(0.2),Y(0.2),nterm(0);MODIFICATIONS:NH2,17.026549105,OH,18.0105647  \N
55  U-DiAzKs    -28.006148  f   crosslinker:AsymetricSingleAminoAcidRestrictedCrossLinker:Name:Xd-DiAzKs;MASS:-28.006148;FIRSTLINKEDAMINOACIDS:X;SECONDLINKEDAMINOACIDS:Xd  \N
48  DSSO+NH+OH  158.0037648 f   crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:DSSO;MASS:158.0037648;LINKEDAMINOACIDS:K(0),S(0.2),T(0.2),Y(0.2),nterm(0);MODIFICATIONS:NH2,17.026549105,OH,18.0105647    \N
39  Photo-Leucine   -16.0313    f   crosslinker:AsymetricSingleAminoAcidRestrictedCrossLinker:Name:Photo-Leucine;MASS:-16.0313;FIRSTLINKEDAMINOACIDS:Ccm,Mox,R,H,K,D,E,S,T,N,Q,C,U,G,P,A,V,I,L,M,F,Y,W;SECONDLINKEDAMINOACIDS:L,Mleu    \N
49  #dont' use Photo-Leu    -17.039125  f   crosslinker:AsymetricSingleAminoAcidRestrictedCrossLinker:Name:Photo-Leucine;MASS:-17.039125;FIRSTLINKEDAMINOACIDS:Ccm,Mox,R,H,K,D,E,S,T,N,Q,C,U,G,P,A,V,I,L,M,F,Y,W;SECONDLINKEDAMINOACIDS:L   \N
56  Azidophenylalanine (Faz)    -28.006148  f   crosslinker:AsymetricSingleAminoAcidRestrictedCrossLinker:Name:Faz;MASS:-28.006148;FIRSTLINKEDAMINOACIDS:Faz;SECONDLINKEDAMINOACIDS:*   \N
57  Azidophenylalanine (F)  12.995248965    f   crosslinker:AsymetricSingleAminoAcidRestrictedCrossLinker:Name:Faz;MASS:12.995248965;FIRSTLINKEDAMINOACIDS:F;SECONDLINKEDAMINOACIDS:*   \N
51  DSP (loop,amidated,hydrolized)  173.98092087    f   crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:DSP;MASS:173.98092087;LINKEDAMINOACIDS:K(0),S(0.2),T(0.2),Y(0.2),nterm(0);MODIFICATIONS:NH2,17.026549105,OH,18.0105647,LOOP,0 \N
52  DSP (amidated,hydrolized)   173.98092087    f   crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:DSP;MASS:173.98092087;LINKEDAMINOACIDS:K(0),S(0.2),T(0.2),Y(0.2),nterm(0);MODIFICATIONS:NH2,17.026549105,OH,18.0105647    \N
53  Xd-DiAzKs   -28.006148  f   crosslinker:AsymetricSingleAminoAcidRestrictedCrossLinker:Name:Xd-DiAzKs;MASS:-28.006148;FIRSTLINKEDAMINOACIDS:X;SECONDLINKEDAMINOACIDS:Xd  \N
54  Xd-DiAzKs (O,H2O)   -28.006148  f   crosslinker:AsymetricSingleAminoAcidRestrictedCrossLinker:Name:Xd-DiAzKs;MASS:-28.006148;FIRSTLINKEDAMINOACIDS:X;SECONDLINKEDAMINOACIDS:Xd;MODIFICATIONS:O,15.99491463,H2O,18.0105647   \N
33  Linear Search   0   f   crosslinker:LinearCrosslinker:NAME:linear   \N
115 DTSSP   173.98092087    f   crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:DTSSP;MASS:173.98092087;LINKEDAMINOACIDS:K(0),S(0.2),T(0.2),Y(0.2),nterm(0)   \N
117 NonCovalent 0   f   crosslinker:NonCovalentBound:Name:NonCovalent   \N
116 DTSSP+TRIS+OH   173.98092087    f   crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:DTSSP;MASS:173.98092087;LINKEDAMINOACIDS:K(0),S(0.2),T(0.2),Y(0.2),nterm(0);MODIFICATIONS:TRIS,121.073893275,OH,18.0105647    \N
119 DTSSP+Disulphide    171.9652708 f   crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:disulph+dtssp;MASS:171.9652708;LINKEDAMINOACIDS:C,K,S,T,Y \N
118 Disulphide  -2.01565007 f   crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:Disulphide;MASS:-2.01565007;LINKEDAMINOACIDS:C    \N
120 Shuffled DTSSP (KSTY to C)  85.9826354  f   crosslinker:AsymetricSingleAminoAcidRestrictedCrossLinker:Name:SDTSSP;MASS:85.9826354;FIRSTLINKEDAMINOACIDS:K,S,T,Y;SECONDLINKEDAMINOACIDS:C    \N
121 SDA 82.04186484 f   crosslinker:AsymetricSingleAminoAcidRestrictedCrossLinker:Name:SDA;MASS:82.04186484;FIRSTLINKEDAMINOACIDS:R,H,K,D,E,S,T,N,Q,C,U,G,P,A,V,I,L,M,F,Y,W;SECONDLINKEDAMINOACIDS:K,S,Y,T,K8,nterm \N
13  wrong mass SDA  82.0413162600906    f   crosslinker:AsymetricSingleAminoAcidRestrictedCrossLinker:Name:SDA;MASS:82.0413162600906;FIRSTLINKEDAMINOACIDS:R,H,K,D,E,S,T,N,Q,C,U,G,P,A,V,I,L,M,F,Y,W;SECONDLINKEDAMINOACIDS:K,S,Y,T,K8,nterm    \N
\.


--
-- Name: crosslinker_id_seq; Type: SEQUENCE SET; Schema: public; Owner: myXi3_user
--

SELECT pg_catalog.setval('crosslinker_id_seq', 121, true);


--
-- Data for Name: enzyme; Type: TABLE DATA; Schema: public; Owner: myXi3_user
--

COPY enzyme (id, name, description, is_default) FROM stdin;
2   V8  digestion:PostAAConstrainedDigestion:DIGESTED:E,D;NAME=V8   \N
3   Lys-C   digestion:PostAAConstrainedDigestion:DIGESTED:K;ConstrainingAminoAcids:P;NAME=Lys-C \N
4   no digestion    digestion:NoDigestion:  \N
5   Trypsin/P(R10,K8)   digestion:PostAAConstrainedDigestion:DIGESTED:R10,K8;ConstrainingAminoAcids:;NAME=Trypsin/P(R10,K8) \N
10  Lys-C/P digestion:PostAAConstrainedDigestion:DIGESTED:K;ConstrainingAminoAcids:;NAME=Lys-C/P    \N
11  Trypsin/P   digestion:PostAAConstrainedDigestion:DIGESTED:R,K,R10,K8;ConstrainingAminoAcids:;NAME=Trypsin/P \N
12  Trypsin/P+V8    digestion:PostAAConstrainedDigestion:DIGESTED:R,K,R10,K8,E,D;ConstrainingAminoAcids:;NAME=Trypsin/P+V8  \N
13  ProteinaseK digestion:PostAAConstrainedDigestion:DIGESTED:A,V,L,M,I,F,Y,W;ConstrainingAminoAcids:;NAME=ProteinaseK  \N
14  ProteinaseK & Trypsin\\P    digestion:PostAAConstrainedDigestion:DIGESTED:A,V,L,M,I,F,Y,W,K,R,K8,R10;ConstrainingAminoAcids:;NAME=ProteinaseK+Trypsin\\P    \N
15  Chymotrypsin    digestion:PostAAConstrainedDigestion:DIGESTED:F,L,W,Y;ConstrainingAminoAcids:;NAME=Chymotrypsin \N
16  Everything  digestion:PostAAConstrainedDigestion:DIGESTED:R,H,K,D,E,S,T,N,Q,C,U,G,P,A,V,I,L,M,F,Y,W,Ccm;ConstrainingAminoAcids:;NAME=Everything \N
17  Trypsin+Chemotrypsin    digestion:PostAAConstrainedDigestion:DIGESTED:K,R,K8,R10,F,L,W,Y;ConstrainingAminoAcids:;NAME=Trypsin   \N
20  Asp-N(D)    digestion:AAConstrainedDigestion:CTERMDIGEST:;NTERMDIGEST:D;NAME=ASP-N  \N
21  Asp-N(E)    digestion:AAConstrainedDigestion:CTERMDIGEST:;NTERMDIGEST:E;NAME=ASP-N  \N
18  Trypsin/P+ASP-N(D)  digestion:AAConstrainedDigestion:CTERMDIGEST:K,R,K8,R10;NTERMDIGEST:D;NAME=Trypsin/P+ASP-N  \N
23  Trypsin/P+ASP-N(E)  digestion:AAConstrainedDigestion:CTERMDIGEST:K,R,K8,R10;NTERMDIGEST:E;NAME=Trypsin/P+ASP-N(E)   \N
19  Asp-N(DE)   digestion:AAConstrainedDigestion:CTERMDIGEST:;NTERMDIGEST:D,E;NAME=ASP-N    \N
25  Thermolzsin digestion:AAConstrainedDigestion:CTERMDIGEST:;NTERMDIGEST:L,F,V,I,A,M;NAME=Thermolysin  \N
1   Trypsin digestion:PostAAConstrainedDigestion:DIGESTED:K,R,K8,R10;ConstrainingAminoAcids:P;NAME=Trypsin  t
22  Trypsin/P+ASP-N(DE) digestion:AAConstrainedDigestion:CTERMDIGEST:K,R,K8,R10;NTERMDIGEST:D,E;NAME=Trypsin/P+ASP-N(DE)    \N
26  Elastase & Trypsin  digestion:PostAAConstrainedDigestion:DIGESTED:K,R,K8,R10,V,A,G,L,I,S;ConstrainingAminoAcids:P;NAME=Elastase+Trypsin \N
27  Trypsin/P & exopeptidase    digestion:AAConstrainedDigestion:CTERMDIGEST:K,R,K8,R10;NTERMDIGEST:K,S,T,Y;NAME=Trypsin/P+exopeptidase \N
24  Elastase    digestion:PostAAConstrainedDigestion:DIGESTED:V,A,G,L,I,S;ConstrainingAminoAcids:P;NAME=Elastase    \N
\.


--
-- Name: enzyme_id_seq; Type: SEQUENCE SET; Schema: public; Owner: myXi3_user
--

SELECT pg_catalog.setval('enzyme_id_seq', 50, true);


--
-- Name: crosslinker_pkey; Type: CONSTRAINT; Schema: public; Owner: myXi3_user; Tablespace:
--

ALTER TABLE ONLY crosslinker
    ADD CONSTRAINT crosslinker_pkey PRIMARY KEY (id);


--
-- Name: enzyme_pkey; Type: CONSTRAINT; Schema: public; Owner: myXi3_user; Tablespace:
--

ALTER TABLE ONLY enzyme
    ADD CONSTRAINT enzyme_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

