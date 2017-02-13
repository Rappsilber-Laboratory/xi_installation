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
-- Name: base_setting; Type: TABLE; Schema: public; Owner: myXi3_user; Tablespace: 
--

CREATE TABLE base_setting (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    setting text
);


ALTER TABLE base_setting OWNER TO myXi3_user;

--
-- Name: base_setting_id_seq; Type: SEQUENCE; Schema: public; Owner: myXi3_user
--

CREATE SEQUENCE base_setting_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE base_setting_id_seq OWNER TO myXi3_user;

--
-- Name: base_setting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: myXi3_user
--

ALTER SEQUENCE base_setting_id_seq OWNED BY base_setting.id;


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
-- Name: loss; Type: TABLE; Schema: public; Owner: myXi3_user; Tablespace: 
--

CREATE TABLE loss (
    id integer NOT NULL,
    name character varying(50),
    lost_mass numeric,
    description text,
    is_default boolean
);


ALTER TABLE loss OWNER TO myXi3_user;

--
-- Name: COLUMN loss.is_default; Type: COMMENT; Schema: public; Owner: myXi3_user
--

COMMENT ON COLUMN loss.is_default IS 'Is this loss chosen by default?';


--
-- Name: loss_id_seq; Type: SEQUENCE; Schema: public; Owner: myXi3_user
--

CREATE SEQUENCE loss_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE loss_id_seq OWNER TO myXi3_user;

--
-- Name: loss_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: myXi3_user
--

ALTER SEQUENCE loss_id_seq OWNED BY loss.id;


--
-- Name: match_type; Type: TABLE; Schema: public; Owner: myXi3_user; Tablespace: 
--

CREATE TABLE match_type (
    id integer NOT NULL,
    name character varying(50)
);


ALTER TABLE match_type OWNER TO myXi3_user;

--
-- Name: match_type_id_seq; Type: SEQUENCE; Schema: public; Owner: myXi3_user
--

CREATE SEQUENCE match_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE match_type_id_seq OWNER TO myXi3_user;

--
-- Name: match_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: myXi3_user
--

ALTER SEQUENCE match_type_id_seq OWNED BY match_type.id;


--
-- Name: modification; Type: TABLE; Schema: public; Owner: myXi3_user; Tablespace: 
--

CREATE TABLE modification (
    id integer NOT NULL,
    name character varying(1000),
    description text,
    formula character varying,
    symbol character varying,
    is_default_fixed boolean,
    is_default_var boolean
);


ALTER TABLE modification OWNER TO myXi3_user;

--
-- Name: COLUMN modification.is_default_fixed; Type: COMMENT; Schema: public; Owner: myXi3_user
--

COMMENT ON COLUMN modification.is_default_fixed IS 'Is this a default fixed modification?';


--
-- Name: COLUMN modification.is_default_var; Type: COMMENT; Schema: public; Owner: myXi3_user
--

COMMENT ON COLUMN modification.is_default_var IS 'Is this a default var modification?';


--
-- Name: modification_id_seq; Type: SEQUENCE; Schema: public; Owner: myXi3_user
--

CREATE SEQUENCE modification_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE modification_id_seq OWNER TO myXi3_user;

--
-- Name: modification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: myXi3_user
--

ALTER SEQUENCE modification_id_seq OWNED BY modification.id;


--
-- Name: user_groups; Type: TABLE; Schema: public; Owner: myXi3_user; Tablespace: 
--

CREATE TABLE user_groups (
    id integer NOT NULL,
    name character varying(100),
    max_search_count integer,
    max_spectra integer,
    max_aas integer,
    search_lifetime_days integer,
    super_user boolean,
    see_all boolean,
    can_add_search boolean,
    max_searches_per_day integer
);


ALTER TABLE user_groups OWNER TO myXi3_user;

--
-- Name: COLUMN user_groups.max_search_count; Type: COMMENT; Schema: public; Owner: myXi3_user
--

COMMENT ON COLUMN user_groups.max_search_count IS 'Max number of searches for this user type';


--
-- Name: COLUMN user_groups.max_spectra; Type: COMMENT; Schema: public; Owner: myXi3_user
--

COMMENT ON COLUMN user_groups.max_spectra IS 'Max number of spectra uploadable by this user type';


--
-- Name: COLUMN user_groups.max_aas; Type: COMMENT; Schema: public; Owner: myXi3_user
--

COMMENT ON COLUMN user_groups.max_aas IS 'Max number of amino acids (fasta size) uploadable by this user type';


--
-- Name: COLUMN user_groups.search_lifetime_days; Type: COMMENT; Schema: public; Owner: myXi3_user
--

COMMENT ON COLUMN user_groups.search_lifetime_days IS 'Retention lifetime of searches for this user type';


--
-- Name: COLUMN user_groups.super_user; Type: COMMENT; Schema: public; Owner: myXi3_user
--

COMMENT ON COLUMN user_groups.super_user IS 'Can this user type see all other users data and change their user settings?';


--
-- Name: COLUMN user_groups.see_all; Type: COMMENT; Schema: public; Owner: myXi3_user
--

COMMENT ON COLUMN user_groups.see_all IS 'Can this user type see all other users non-private searches, seqs, acqs?';


--
-- Name: COLUMN user_groups.can_add_search; Type: COMMENT; Schema: public; Owner: myXi3_user
--

COMMENT ON COLUMN user_groups.can_add_search IS 'Can this user type add new searches?';


--
-- Name: COLUMN user_groups.max_searches_per_day; Type: COMMENT; Schema: public; Owner: myXi3_user
--

COMMENT ON COLUMN user_groups.max_searches_per_day IS 'Throttle on number of searches per calendar day for this user type';


--
-- Name: user_groups_id; Type: SEQUENCE; Schema: public; Owner: myXi3_user
--

CREATE SEQUENCE user_groups_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_groups_id OWNER TO myXi3_user;

--
-- Name: user_groups_id; Type: SEQUENCE OWNED BY; Schema: public; Owner: myXi3_user
--

ALTER SEQUENCE user_groups_id OWNED BY user_groups.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: myXi3_user
--

ALTER TABLE ONLY base_setting ALTER COLUMN id SET DEFAULT nextval('base_setting_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: myXi3_user
--

ALTER TABLE ONLY crosslinker ALTER COLUMN id SET DEFAULT nextval('crosslinker_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: myXi3_user
--

ALTER TABLE ONLY enzyme ALTER COLUMN id SET DEFAULT nextval('enzyme_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: myXi3_user
--

ALTER TABLE ONLY loss ALTER COLUMN id SET DEFAULT nextval('loss_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: myXi3_user
--

ALTER TABLE ONLY match_type ALTER COLUMN id SET DEFAULT nextval('match_type_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: myXi3_user
--

ALTER TABLE ONLY modification ALTER COLUMN id SET DEFAULT nextval('modification_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: myXi3_user
--

ALTER TABLE ONLY user_groups ALTER COLUMN id SET DEFAULT nextval('user_groups_id'::regclass);


--
-- Data for Name: base_setting; Type: TABLE DATA; Schema: public; Owner: myXi3_user
--

COPY base_setting (id, name, setting) FROM stdin;
1	base_directory_path	/xi_data/
4	IsotopPattern	Averagin
5	minCharge	3
6	xmass	USER:myXi3_user;DRIVER:org.postgresql.Driver;URL:jdbc:postgresql://dbIP:5432/xmass2
7	xmassoutput	false
8	xmassscore	match_score
12	TOPMATCHESONLY	false
13	topmgxhits	10
16	#LOWRESOLUTION\n	FALSE
15	OM_MAX_MASS	1200
14	OM_MIN_MASS	0
3	EVALUATELINEARS	true
2	UseCPUs	-2
11	sqlbuffer	100
10	BufferOutput	4000
9	BufferInput	1000
35	mgcpeaks	10
\.


--
-- Name: base_setting_id_seq; Type: SEQUENCE SET; Schema: public; Owner: myXi3_user
--

SELECT pg_catalog.setval('base_setting_id_seq', 35, true);


--
-- Data for Name: crosslinker; Type: TABLE DATA; Schema: public; Owner: myXi3_user
--

COPY crosslinker (id, name, mass, is_decoy, description, is_default) FROM stdin;
1	BS2G	96.02112055	f	crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:BS2G;MASS:96.02112055;LINKEDAMINOACIDS:K,S,T,Y,nterm	\N
3	XL9	403.137950	f	crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:XL9;MASS:403.137950;LINKEDAMINOACIDS:K,S,T,Y,nterm	\N
4	XL10	402.142701	f	crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:XL10;MASS:402.142701;LINKEDAMINOACIDS:K,S,T,Y,nterm	\N
9	BS2G (K only)	96.02112055	f	crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:BS2G;MASS:96.02112055;LINKEDAMINOACIDS:K,nterm	\N
2	BS3	138.06807961	f	crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:BS3;MASS:138.06807961;LINKEDAMINOACIDS:K(0),S(0.2),T(0.2),Y(0.2),nterm(0)	\N
7	BS3+NH+OH+INTERNAL	138.06807	f	crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:BS3;MASS:138.06807961;LINKEDAMINOACIDS:K(0),S(0.2),T(0.2),Y(0.2),nterm(0);MODIFICATIONS:NH2,17.026549105,OH,18.0105647,LOOP,0	\N
5	EDC	-18.01056027	f	crosslinker:AsymetricSingleAminoAcidRestrictedCrossLinker:Name:EDC;MASS:-18.01056027;FIRSTLINKEDAMINOACIDS:E,D,Nda,Qda,cterm;SECONDLINKEDAMINOACIDS:K,S,Y,T,nterm	\N
12	EDC (N,Q -17)	-17.0260005250906	f	crosslinker:AsymetricSingleAminoAcidRestrictedCrossLinker:Name:EDC;MASS:-17.0260005250906;FIRSTLINKEDAMINOACIDS:N,Q,cterm;SECONDLINKEDAMINOACIDS:K,S,Y,T,nterm	\N
15	BS3 (K only)	138.06807	f	crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:BS3;MASS:138.06807961;LINKEDAMINOACIDS:K(0),nterm(0);	\N
6	BS(PEG)5	302.13655	f	crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:BS(PEG)5;MASS:302.13655;LINKEDAMINOACIDS:K(0),S(0.2),T(0.2),Y(0.2),nterm(0)	\N
26	TargetModification	0	f	crosslinker:DummyCrosslinker:Name:TargetModification	\N
8	BS3+NH+OH	138.06807	f	crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:BS3;MASS:138.06807961;LINKEDAMINOACIDS:K(0),S(0.2),T(0.2),Y(0.2),nterm(0);MODIFICATIONS:NH2,17.026549105,OH,18.0105647	\N
10	BS3-d4	142.0931769836	f	crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:BS3-d4;MASS:142.0931769836;LINKEDAMINOACIDS:K(0),S(0.2),T(0.2),Y(0.2),nterm(0)	\N
16	BS3(K4K6K8STY)	138.06807	f	crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:BS3;MASS:138.06807961;LINKEDAMINOACIDS:K(0),K8(0),K4(0),K6(0),S(0.2),T(0.2),Y(0.2),nterm(0);MODIFICATIONS:NH2,17.026549105,OH,18.0105647,LOOP,0	\N
17	OpenModification	0	f	crosslinker:DummyCrosslinker:Name:OpenModification	\N
11	BS3-d4+OH+NH2+loop	142.0931769836	f	crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:BS3-d4;MASS:142.0931769836;LINKEDAMINOACIDS:K(0),S(0.2),T(0.2),Y(0.2),nterm(0);MODIFICATIONS:NH2,17.026549105,OH,18.0105647,LOOP,0	\N
18	BS3-d4+OH+NH2	142.0931769836	f	crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:BS3-d4;MASS:142.0931769836;LINKEDAMINOACIDS:K(0),S(0.2),T(0.2),Y(0.2),nterm(0);MODIFICATIONS:NH2,17.026549105,OH,18.0105647	\N
23	BS3 (K) +NH+OH	138.06807	f	crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:BS3;MASS:138.06807961;LINKEDAMINOACIDS:K(0),nterm(0);MODIFICATIONS:NH2,17.026549105,OH,18.0105647	\N
24	EGS (KSTY)+NH2+OH	226.047738	f	crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:EGS;MASS:226.047738;LINKEDAMINOACIDS:K(0),S(0.2),T(0.2),Y(0.2),nterm(0);MODIFICATIONS:NH2,17.026549105,OH,18.0105647	\N
25	BS2G (KSTY) (NH2 OH)	96.02112055	f	crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:BS2G;MASS:96.02112055;LINKEDAMINOACIDS:K(0),S(0.2),T(0.2),Y(0.2),nterm(0);MODIFICATIONS:NH2,17.026549105,OH,18.0105647	\N
29	LC-SDA	195.125928855	f	crosslinker:AsymetricSingleAminoAcidRestrictedCrossLinker:Name:LC-SDA;MASS:195.125928855;FIRSTLINKEDAMINOACIDS:R,H,K,D,E,S,T,N,Q,C,U,G,P,A,V,I,L,M,F,Y,W;SECONDLINKEDAMINOACIDS:K,S,Y,T,nterm	\N
27	Tyr Any -2H	-2.01565007	f	crosslinker:AsymetricSingleAminoAcidRestrictedCrossLinker:Name:Tyr-2H;MASS:-2.01565007;FIRSTLINKEDAMINOACIDS:R,H,K,D,E,S,T,N,Q,C,U,G,P,A,V,I,L,M,F,Y,W;SECONDLINKEDAMINOACIDS:Y	\N
28	-2H	-2.01565007	f	crosslinker:AsymetricSingleAminoAcidRestrictedCrossLinker:Name:Tyr-2H;MASS:-2.01565007;FIRSTLINKEDAMINOACIDS:R,H,K,D,E,S,T,N,Q,C,U,G,P,A,V,I,L,M,F,Y,W;SECONDLINKEDAMINOACIDS:R,H,K,D,E,S,T,N,Q,C,U,G,P,A,V,I,L,M,F,Y,W	\N
30	-1H	-1.007825	f	crosslinker:AsymetricSingleAminoAcidRestrictedCrossLinker:Name:Tyr-1H;MASS:-1.007825;FIRSTLINKEDAMINOACIDS:R,H,K,D,E,S,T,N,Q,C,U,G,P,A,V,I,L,M,F,Y,W;SECONDLINKEDAMINOACIDS:R,H,K,D,E,S,T,N,Q,C,U,G,P,A,V,I,L,M,F,Y,W	\N
34	DECOY BS2G (KSTY)	96.02112055	t	crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:BS2G;MASS:96.02112055;LINKEDAMINOACIDS:K(0),S(0.2),T(0.2),Y(0.2),nterm(0);	\N
31	-3H	-3.023475	f	crosslinker:AsymetricSingleAminoAcidRestrictedCrossLinker:Name:Tyr-3H;MASS:-3.023475;FIRSTLINKEDAMINOACIDS:R,H,K,D,E,S,T,N,Q,C,U,G,P,A,V,I,L,M,F,Y,W;SECONDLINKEDAMINOACIDS:R,H,K,D,E,S,T,N,Q,C,U,G,P,A,V,I,L,M,F,Y,W	\N
32	-OH	-17.002740	f	crosslinker:AsymetricSingleAminoAcidRestrictedCrossLinker:Name:Tyr-OH;MASS:-17.002740;FIRSTLINKEDAMINOACIDS:R,H,K,D,E,S,T,N,Q,C,U,G,P,A,V,I,L,M,F,Y,W;SECONDLINKEDAMINOACIDS:R,H,K,D,E,S,T,N,Q,C,U,G,P,A,V,I,L,M,F,Y,W	\N
14	BS3+NH+OH	138.06807	f	crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:BS3;MASS:138.06807961;LINKEDAMINOACIDS:K(0),S(0.2),T(0.2),Y(0.2),nterm(0);MODIFICATIONS:NH2,17.026549105,OH,18.0105647	t
38	BENZO (C14H8O2)	208.052430	f	crosslinker:AsymetricSingleAminoAcidRestrictedCrossLinker:Name:BENZO;MASS:208.052430;FIRSTLINKEDAMINOACIDS:R,H,K,D,E,S,T,N,Q,C,U,G,P,A,V,I,L,M,F,Y,W,K8,Ccm,Mox;SECONDLINKEDAMINOACIDS:K,S,Y,T,K8,nterm	\N
46	BPM	277.073894	f	crosslinker:AsymetricSingleAminoAcidRestrictedCrossLinker:Name:BPM;MASS:277.073894;FIRSTLINKEDAMINOACIDS:R,H,K,D,E,S,T,N,Q,C,U,G,P,A,V,I,L,M,F,Y,W,Mox,Ccm;SECONDLINKEDAMINOACIDS:C	\N
37	DECOY BS3 - Ala	67.03096	t	crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:BS3;MASS:67.03096;LINKEDAMINOACIDS:K(0),S(0.2),T(0.2),Y(0.2),nterm(0)	\N
36	DECOY BS3 - Gly	81.04661	t	crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:BS3;MASS:81.04661;LINKEDAMINOACIDS:K(0),S(0.2),T(0.2),Y(0.2),nterm(0)	\N
35	DECOY BS3 - 30Da	108.06807	t	crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:BS3;MASS:108.06807961;LINKEDAMINOACIDS:K(0),S(0.2),T(0.2),Y(0.2),nterm(0)	\N
40	Photo-Methionine	-19.972072	f	crosslinker:AsymetricSingleAminoAcidRestrictedCrossLinker:Name:Photo-Methionine;MASS:-19.972072;FIRSTLINKEDAMINOACIDS:Ccm,Mox,R,H,K,D,E,S,T,N,Q,C,U,G,P,A,V,I,L,M,F,Y,W;SECONDLINKEDAMINOACIDS:M	\N
41	DASD-BS3-like	365.998031	f	crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:DASD-BS3-like;MASS:365.998031;LINKEDAMINOACIDS:K(0),S(0.2),T(0.2),Y(0.2),nterm(0)	\N
42	DASD-non-specfific	365.998031	f	crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:DASD-non-specfific;MASS:365.998031;LINKEDAMINOACIDS:R,H,K,D,E,S,T,N,Q,C,U,G,P,A,V,I,L,M,F,Y,W	\N
47	Tyr Tyr -2H	-2.01565007	f	crosslinker:AsymetricSingleAminoAcidRestrictedCrossLinker:Name:Tyr-2H;MASS:-2.01565007;FIRSTLINKEDAMINOACIDS:Y;SECONDLINKEDAMINOACIDS:Y	\N
44	BSOCOES+NH+OH	205.988512	f	crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:BSOCOES;MASS:205.988512;LINKEDAMINOACIDS:K(0),S(0.2),T(0.2),Y(0.2),nterm(0);MODIFICATIONS:NH2,17.026549105,OH,18.0105647	\N
43	TSAT+NH+OH	137.093196	f	crosslinker:SymetricNarrySingleAminoAcidRestrictedCrossLinker:Name:TSAT;MASS:137.011294;LINKEDAMINOACIDS:K(0),S(0.2),T(0.2),Y(0.2),nterm(0);MODIFICATIONS:NH2,17.026549105,OH,18.0105647;MOIETIES:3	\N
45	DST+NH+OH	113.995310	f	crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:DST;MASS:113.995310;LINKEDAMINOACIDS:K(0),S(0.2),T(0.2),Y(0.2),nterm(0);MODIFICATIONS:NH2,17.026549105,OH,18.0105647	\N
55	U-DiAzKs	-28.006148	f	crosslinker:AsymetricSingleAminoAcidRestrictedCrossLinker:Name:Xd-DiAzKs;MASS:-28.006148;FIRSTLINKEDAMINOACIDS:X;SECONDLINKEDAMINOACIDS:Xd	\N
48	DSSO+NH+OH	158.0037648	f	crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:DSSO;MASS:158.0037648;LINKEDAMINOACIDS:K(0),S(0.2),T(0.2),Y(0.2),nterm(0);MODIFICATIONS:NH2,17.026549105,OH,18.0105647	\N
39	Photo-Leucine	-16.0313	f	crosslinker:AsymetricSingleAminoAcidRestrictedCrossLinker:Name:Photo-Leucine;MASS:-16.0313;FIRSTLINKEDAMINOACIDS:Ccm,Mox,R,H,K,D,E,S,T,N,Q,C,U,G,P,A,V,I,L,M,F,Y,W;SECONDLINKEDAMINOACIDS:L,Mleu	\N
49	#dont' use Photo-Leu	-17.039125	f	crosslinker:AsymetricSingleAminoAcidRestrictedCrossLinker:Name:Photo-Leucine;MASS:-17.039125;FIRSTLINKEDAMINOACIDS:Ccm,Mox,R,H,K,D,E,S,T,N,Q,C,U,G,P,A,V,I,L,M,F,Y,W;SECONDLINKEDAMINOACIDS:L	\N
56	Azidophenylalanine (Faz)	-28.006148	f	crosslinker:AsymetricSingleAminoAcidRestrictedCrossLinker:Name:Faz;MASS:-28.006148;FIRSTLINKEDAMINOACIDS:Faz;SECONDLINKEDAMINOACIDS:*	\N
57	Azidophenylalanine (F)	12.995248965	f	crosslinker:AsymetricSingleAminoAcidRestrictedCrossLinker:Name:Faz;MASS:12.995248965;FIRSTLINKEDAMINOACIDS:F;SECONDLINKEDAMINOACIDS:*	\N
51	DSP (loop,amidated,hydrolized)	173.98092087	f	crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:DSP;MASS:173.98092087;LINKEDAMINOACIDS:K(0),S(0.2),T(0.2),Y(0.2),nterm(0);MODIFICATIONS:NH2,17.026549105,OH,18.0105647,LOOP,0	\N
52	DSP (amidated,hydrolized)	173.98092087	f	crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:DSP;MASS:173.98092087;LINKEDAMINOACIDS:K(0),S(0.2),T(0.2),Y(0.2),nterm(0);MODIFICATIONS:NH2,17.026549105,OH,18.0105647	\N
53	Xd-DiAzKs	-28.006148	f	crosslinker:AsymetricSingleAminoAcidRestrictedCrossLinker:Name:Xd-DiAzKs;MASS:-28.006148;FIRSTLINKEDAMINOACIDS:X;SECONDLINKEDAMINOACIDS:Xd	\N
54	Xd-DiAzKs (O,H2O)	-28.006148	f	crosslinker:AsymetricSingleAminoAcidRestrictedCrossLinker:Name:Xd-DiAzKs;MASS:-28.006148;FIRSTLINKEDAMINOACIDS:X;SECONDLINKEDAMINOACIDS:Xd;MODIFICATIONS:O,15.99491463,H2O,18.0105647	\N
33	Linear Search	0	f	crosslinker:LinearCrosslinker:NAME:linear	\N
115	DTSSP	173.98092087	f	crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:DTSSP;MASS:173.98092087;LINKEDAMINOACIDS:K(0),S(0.2),T(0.2),Y(0.2),nterm(0)	\N
117	NonCovalent	0	f	crosslinker:NonCovalentBound:Name:NonCovalent	\N
116	DTSSP+TRIS+OH	173.98092087	f	crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:DTSSP;MASS:173.98092087;LINKEDAMINOACIDS:K(0),S(0.2),T(0.2),Y(0.2),nterm(0);MODIFICATIONS:TRIS,121.073893275,OH,18.0105647	\N
119	DTSSP+Disulphide	171.9652708	f	crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:disulph+dtssp;MASS:171.9652708;LINKEDAMINOACIDS:C,K,S,T,Y	\N
118	Disulphide	-2.01565007	f	crosslinker:SymetricSingleAminoAcidRestrictedCrossLinker:Name:Disulphide;MASS:-2.01565007;LINKEDAMINOACIDS:C	\N
120	Shuffled DTSSP (KSTY to C)	85.9826354	f	crosslinker:AsymetricSingleAminoAcidRestrictedCrossLinker:Name:SDTSSP;MASS:85.9826354;FIRSTLINKEDAMINOACIDS:K,S,T,Y;SECONDLINKEDAMINOACIDS:C	\N
121	SDA	82.04186484	f	crosslinker:AsymetricSingleAminoAcidRestrictedCrossLinker:Name:SDA;MASS:82.04186484;FIRSTLINKEDAMINOACIDS:R,H,K,D,E,S,T,N,Q,C,U,G,P,A,V,I,L,M,F,Y,W;SECONDLINKEDAMINOACIDS:K,S,Y,T,K8,nterm	\N
13	wrong mass SDA 	82.0413162600906	f	crosslinker:AsymetricSingleAminoAcidRestrictedCrossLinker:Name:SDA;MASS:82.0413162600906;FIRSTLINKEDAMINOACIDS:R,H,K,D,E,S,T,N,Q,C,U,G,P,A,V,I,L,M,F,Y,W;SECONDLINKEDAMINOACIDS:K,S,Y,T,K8,nterm	\N
\.


--
-- Name: crosslinker_id_seq; Type: SEQUENCE SET; Schema: public; Owner: myXi3_user
--

SELECT pg_catalog.setval('crosslinker_id_seq', 121, true);


--
-- Data for Name: enzyme; Type: TABLE DATA; Schema: public; Owner: myXi3_user
--

COPY enzyme (id, name, description, is_default) FROM stdin;
2	V8	digestion:PostAAConstrainedDigestion:DIGESTED:E,D;NAME=V8	\N
3	Lys-C	digestion:PostAAConstrainedDigestion:DIGESTED:K;ConstrainingAminoAcids:P;NAME=Lys-C	\N
4	no digestion	digestion:NoDigestion:	\N
5	Trypsin/P(R10,K8)	digestion:PostAAConstrainedDigestion:DIGESTED:R10,K8;ConstrainingAminoAcids:;NAME=Trypsin/P(R10,K8)	\N
10	Lys-C/P	digestion:PostAAConstrainedDigestion:DIGESTED:K;ConstrainingAminoAcids:;NAME=Lys-C/P	\N
11	Trypsin/P	digestion:PostAAConstrainedDigestion:DIGESTED:R,K,R10,K8;ConstrainingAminoAcids:;NAME=Trypsin/P	\N
12	Trypsin/P+V8	digestion:PostAAConstrainedDigestion:DIGESTED:R,K,R10,K8,E,D;ConstrainingAminoAcids:;NAME=Trypsin/P+V8	\N
13	ProteinaseK	digestion:PostAAConstrainedDigestion:DIGESTED:A,V,L,M,I,F,Y,W;ConstrainingAminoAcids:;NAME=ProteinaseK	\N
14	ProteinaseK & Trypsin\\P	digestion:PostAAConstrainedDigestion:DIGESTED:A,V,L,M,I,F,Y,W,K,R,K8,R10;ConstrainingAminoAcids:;NAME=ProteinaseK+Trypsin\\P	\N
15	Chymotrypsin	digestion:PostAAConstrainedDigestion:DIGESTED:F,L,W,Y;ConstrainingAminoAcids:;NAME=Chymotrypsin	\N
16	Everything	digestion:PostAAConstrainedDigestion:DIGESTED:R,H,K,D,E,S,T,N,Q,C,U,G,P,A,V,I,L,M,F,Y,W,Ccm;ConstrainingAminoAcids:;NAME=Everything	\N
17	Trypsin+Chemotrypsin	digestion:PostAAConstrainedDigestion:DIGESTED:K,R,K8,R10,F,L,W,Y;ConstrainingAminoAcids:;NAME=Trypsin	\N
20	Asp-N(D)	digestion:AAConstrainedDigestion:CTERMDIGEST:;NTERMDIGEST:D;NAME=ASP-N	\N
21	Asp-N(E)	digestion:AAConstrainedDigestion:CTERMDIGEST:;NTERMDIGEST:E;NAME=ASP-N	\N
18	Trypsin/P+ASP-N(D)	digestion:AAConstrainedDigestion:CTERMDIGEST:K,R,K8,R10;NTERMDIGEST:D;NAME=Trypsin/P+ASP-N	\N
23	Trypsin/P+ASP-N(E)	digestion:AAConstrainedDigestion:CTERMDIGEST:K,R,K8,R10;NTERMDIGEST:E;NAME=Trypsin/P+ASP-N(E)	\N
19	Asp-N(DE)	digestion:AAConstrainedDigestion:CTERMDIGEST:;NTERMDIGEST:D,E;NAME=ASP-N	\N
25	Thermolzsin	digestion:AAConstrainedDigestion:CTERMDIGEST:;NTERMDIGEST:L,F,V,I,A,M;NAME=Thermolysin	\N
1	Trypsin	digestion:PostAAConstrainedDigestion:DIGESTED:K,R,K8,R10;ConstrainingAminoAcids:P;NAME=Trypsin	t
22	Trypsin/P+ASP-N(DE)	digestion:AAConstrainedDigestion:CTERMDIGEST:K,R,K8,R10;NTERMDIGEST:D,E;NAME=Trypsin/P+ASP-N(DE)	\N
26	Elastase & Trypsin	digestion:PostAAConstrainedDigestion:DIGESTED:K,R,K8,R10,V,A,G,L,I,S;ConstrainingAminoAcids:P;NAME=Elastase+Trypsin	\N
27	Trypsin/P & exopeptidase	digestion:AAConstrainedDigestion:CTERMDIGEST:K,R,K8,R10;NTERMDIGEST:K,S,T,Y;NAME=Trypsin/P+exopeptidase	\N
24	Elastase	digestion:PostAAConstrainedDigestion:DIGESTED:V,A,G,L,I,S;ConstrainingAminoAcids:P;NAME=Elastase	\N
\.


--
-- Name: enzyme_id_seq; Type: SEQUENCE SET; Schema: public; Owner: myXi3_user
--

SELECT pg_catalog.setval('enzyme_id_seq', 50, true);


--
-- Data for Name: loss; Type: TABLE DATA; Schema: public; Owner: myXi3_user
--

COPY loss (id, name, lost_mass, description, is_default) FROM stdin;
1	- H20	\N	loss:AminoAcidRestrictedLoss:NAME:H20;aminoacids:S,T,D,E;MASS:18.01056027;cterm	t
2	- NH3	\N	loss:AminoAcidRestrictedLoss:NAME:NH3;aminoacids:R,K,N,Q;MASS:17.02654493;nterm	t
4	- CH3SOH	\N	loss:AminoAcidRestrictedLoss:NAME:CH3SOH;aminoacids:Mox;MASS:63.99828547	t
3	- SO2	\N	loss:AminoAcidRestrictedLoss:NAME:SO2;aminoacids:Mox;MASS:63.96189	\N
5	- a ion	\N	loss:AIonLoss	\N
6	- H3PO4	97.976895625	loss:AminoAcidRestrictedLoss:NAME:H3PO4;aminoacids:Sp,Tp;MASS:97.976895625	\N
7	- Y-H3PO4	97.976895625	loss:AminoAcidRestrictedLoss:NAME:H3PO4;aminoacids:Yp;MASS:97.976895625	\N
13	Cross-Linker Break	\N	loss:CrosslinkerModified	\N
\.


--
-- Name: loss_id_seq; Type: SEQUENCE SET; Schema: public; Owner: myXi3_user
--

SELECT pg_catalog.setval('loss_id_seq', 13, true);


--
-- Data for Name: match_type; Type: TABLE DATA; Schema: public; Owner: myXi3_user
--

COPY match_type (id, name) FROM stdin;
1	alpha
2	beta
3	linear
4	gamma
\.


--
-- Name: match_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: myXi3_user
--

SELECT pg_catalog.setval('match_type_id_seq', 8, true);


--
-- Data for Name: modification; Type: TABLE DATA; Schema: public; Owner: myXi3_user
--

COPY modification (id, name, description, formula, symbol, is_default_fixed, is_default_var) FROM stdin;
13	K120	:SYMBOL:K120;MODIFIED:K;MASS:248.11737	\N	\N	\N	\N
39	CarbAM (CKHDEST)	:SYMBOLEXT:cm;MODIFIED:C,K,H,D,E,S,T,Y;DELTAMASS:57.021464	H3C2NO	cm	\N	\N
55	BS3Loop	:SYMBOLEXT:bs3loop;MODIFIED:K,S,T,Y,W;DELTAMASS:138.06807	\N	bs3loop	\N	\N
63	SDA-oxid	:SYMBOLEXT:sda-oxid;MODIFIED:K,S,T,Y;DELTAMASS:98.036780	\N	sda-alk	\N	\N
3	PhosphoSerine	:SYMBOL:Sp;MODIFIED:S;MASS:166.9984	PO3H	p	\N	\N
4	PhosphoThreonine	:SYMBOL:Tp;MODIFIED:T;MASS:181.0140	PO3H	p	\N	\N
5	PhosphoTyrosine	:SYMBOL:Yp;MODIFIED:Y;MASS:243.0296	PO3H	p	\N	\N
6	Deamidation (N)	:SYMBOL:Nda;MODIFIED:N;MASS:115.026397	O -H -N	da	\N	\N
7	Deamidation (Q)	:SYMBOL:Qda;MODIFIED:Q;MASS:129.042047	O -H -N	da	\N	\N
8	Arg6	:SYMBOL:R6;MODIFIED:R;MASS:162.121239	13C6 -C6	6	\N	\N
9	Arg10	:SYMBOL:R10;MODIFIED:R;MASS:166.1093789	13C10 -C10	10	\N	\N
10	Lys4	:SYMBOL:K4;MODIFIED:K;MASS:132.120067	2H4 -4H	4	\N	\N
11	Lys6	:SYMBOL:K6;MODIFIED:K;MASS:134.115089	13C6 -C6	6	\N	\N
12	Lys8	:SYMBOL:K8;MODIFIED:K;MASS:136.1091589	13C8 -C8	8	\N	\N
14	Oxidised Carbamidomethylation	:SYMBOL:Ccmo;MODIFIED:C;MASS:176.025569	C2H3NO2	cmo	\N	\N
15	Oxidation (Q)	:SYMBOL:Qox;MODIFIED:Q;MASS:144.053499	O	ox	\N	\N
16	Oxidation (N)	:SYMBOL:Nox;MODIFIED:N;MASS:130.037849	O	ox	\N	\N
17	Methylation (R)	:SYMBOLEXT:me;MODIFIED:R;DELTAMASS:14.015650	H2 C	me	\N	\N
18	Methylation (K)	:SYMBOLEXT:me;MODIFIED:K;DELTAMASS:14.015650	H2 C	me	\N	\N
19	Dimethylation (R)	:SYMBOLEXT:dme;MODIFIED:R;DELTAMASS:28.031300	H4 C2	dme	\N	\N
20	Dimethylation (K)	:SYMBOLEXT:dme;MODIFIED:K;DELTAMASS:28.031300	H4 C2	dme	\N	\N
21	Trimethylation (R)	:SYMBOLEXT:tme;MODIFIED:R;DELTAMASS:42.046950	H6 C3	tme	\N	\N
22	Trimethylation (K)	:SYMBOLEXT:tme;MODIFIED:K;DELTAMASS:42.046950	H6 C3	tme	\N	\N
23	Acetylation (K)	:SYMBOLEXT:ac;MODIFIED:K;DELTAMASS:42.010565	C2 H2 O	ac	\N	\N
24	Ubiquitinylation residue/GlyGly	:SYMBOLEXT:ub;MODIFIED:K;DELTAMASS:114.042927	H6 C4 N2 O2	ub	\N	\N
25	Methylation (E)	:SYMBOLEXT:me;MODIFIED:E;DELTAMASS:14.015650	H2 C	me	\N	\N
26	Glutamylation (E)	:SYMBOLEXT:glu;MODIFIED:E;DELTAMASS:129.0426	H7 C5 N O3	glu	\N	\N
27	WaterLoss (E)	:SYMBOLEXT:h2o;MODIFIED:E;DELTAMASS:-18.0105647	-H2 -O	h20	\N	\N
66	azidophenylalanine (F)	:SYMBOLEXT:az;MODIFIED:F;DELTAMASS:41.001396965	az	N3 -H1	\N	\N
31	BENZO_HYD	:SYMBOLEXT:benzo_hyd;MODIFIED:K,S,T,Y;DELTAMASS:226.062995	C14 H10 O3	benzo_hyd	\N	\N
32	BENZO	:SYMBOLEXT:benzo_hyd;MODIFIED:R,H,K,D,E,S,T,N,Q,C,U,G,P,A,V,I,L,M,F,Y,W;DELTAMASS:208.052430	C14 H8 O2	benzo_hyd	\N	\N
44	2OH Formyl Kynorenine	:SYMBOLEXT:2ohfk;MODIFIED:W;DELTAMASS:63.97965852	\N	2ohfk	\N	\N
43	Kynurenine	:SYMBOLEXT:kynur;MODIFIED:W;DELTAMASS:3.99491463	\N	kynur	\N	\N
57	Methionine-Leucine-Replacement	:SYMBOLEXT:leu;MODIFIED:M;DELTAMASS:-17.956422	\N	leu	\N	\N
40	Oxidation(CWFYHP)	:SYMBOLEXT:ox;MODIFIED:C,W,F,Y,H,P;DELTAMASS:15.99491463	O	ox	\N	\N
41	Dioxidation(CWF)	:SYMBOLEXT:dox;MODIFIED:C,W,F;DELTAMASS:31.98982926	2O	dox	\N	\N
33	Photo-L-H2O	:SYMBOLEXT:phl-hyd;MODIFIED:L;DELTAMASS:19.979265	-C -H2 +O	phl-hyd	\N	\N
34	Photo-M-H2O	:SYMBOLEXT:phm-hyd;MODIFIED:M;DELTAMASS:-1.961507	-S C H2 O	phm-hyd	\N	\N
36	Photo-M-diazirine	:SYMBOLEXT:phm-diaz;MODIFIED:M;DELTAMASS:8.034076	-S C N2	phm-diaz	\N	\N
35	Photo-L-diazirine	:SYMBOLEXT:phl-diaz;MODIFIED:L;DELTAMASS:11.974848	-C -H4 +N2	phl-diaz	\N	\N
37	-1H	:SYMBOLEXT:h;MODIFIED:R,H,K,D,E,S,T,N,Q,C,U,G,P,A,V,I,L,M,F,Y,W;DELTAMASS:-1.00782504	-1	h	\N	\N
42	Trioxidation(C)	:SYMBOLEXT:tox;MODIFIED:C;DELTAMASS:47.98474389	3O	tox	\N	\N
45	OH Kynorenine	:SYMBOLEXT:ohk;MODIFIED:W;DELTAMASS:19.98982963	\N	ohk	\N	\N
46	His-Asp-conversion	:SYMBOLEXT:hdc;MODIFIED:H;DELTAMASS:-23.015984	\N	hdc	\N	\N
47	His-Asn-conversion	:SYMBOLEXT:hnc;MODIFIED:H;DELTAMASS:-22.031969	\N	hnc	\N	\N
48	Glutamic semialdehyole	:SYMBOLEXT:gsa;MODIFIED:R;DELTAMASS:-43.053433	\N	gsa	\N	\N
49	Aminoadipic semialdehyole	:SYMBOLEXT:asa;MODIFIED:K;DELTAMASS:-1.031634	\N	asa	\N	\N
50	Pyrrolidone	:SYMBOLEXT:pyrr;MODIFIED:P;DELTAMASS:-27.994915	\N	pyrr	\N	\N
51	Pyroglutmic acid	:SYMBOLEXT:pyrglu;MODIFIED:P;DELTAMASS:13.97926456	\N	pyrglu	\N	\N
52	-2H(T)	:SYMBOLEXT:-2h;MODIFIED:T;DELTAMASS:-2.01565007	\N	-2h	\N	\N
53	BS3Amidated	:SYMBOLEXT:bs3nh;MODIFIED:K,S,T,Y,W;DELTAMASS:155.094619105	\N	bs3nh	\N	\N
54	BS3Hydrolized	:SYMBOLEXT:bs3oh;MODIFIED:K,S,T,Y,W;DELTAMASS:156.0786347	\N	bs3oh	\N	\N
56	Selenium replace Sulfur 	:SYMBOLEXT:sse;MODIFIED:M;DELTAMASS:46.895	Se -S	sse	\N	\N
58	Carbamidomethyl(K)	:SYMBOLEXT:cm;MODIFIED:K;DELTAMASS:57.021464	\N	cm	\N	\N
59	Carbamidomethyl(H)	:SYMBOLEXT:cm;MODIFIED:H;DELTAMASS:57.021464	\N	cm	\N	\N
2	Oxidation (M)	:SYMBOL:Mox;MODIFIED:M;MASS:147.035395	O	ox	\N	t
1	Carbamidomethylation	:SYMBOL:Ccm;MODIFIED:C;MASS:160.03065	H3C2NO	cm	t	\N
61	X-DiAzKs	:SYMBOL:Xd;MODIFIED:K;MASS:254.137891	\N	\N	\N	\N
60	NTerm-26	:SYMBOLEXT:26;MODIFIED:R,H,K,D,E,S,T,N,Q,C,U,G,P,A,V,I,L,M,F,Y,W;DELTAMASS:26.061528	\N	\N	\N	\N
62	SDA-alkene	:SYMBOLEXT:sda-alk;MODIFIED:K,S,T,Y;DELTAMASS:68.026215	\N	sda-alk	\N	\N
64	SDA-Hydro	:SYMBOLEXT:sda-hyd;MODIFIED:K,S,T,Y;DELTAMASS:100.05243	C5 H8 O2	sda-hyd	\N	\N
65	U-DiAzKs	:SYMBOL:Ud,;MODIFIED:U;MASS:254.137891	\N	\N	\N	\N
29	SDA	:SYMBOLEXT:sda;MODIFIED:K,S,T,Y;DELTAMASS:110.04801284	C5 H6 N2 O	sda	\N	\N
30	SDA-loop	:SYMBOLEXT:sda-loop;MODIFIED:K,S,T,Y;DELTAMASS:82.04186484	C5 H6 O	sda-loop	\N	\N
133	Part DTSSP+H (KSTY)	:SYMBOLEXT:sdtssp;MODIFIED:K,S,T,Y;DELTAMASS:87.99828547	C3 H4 O1 S1	sdtssp	f	f
134	Uridine-H3PO4(AILKFWY)	:SYMBOLEXT:uh3po4;MODIFIED:A,I,L,K,F,W,Y,V;DELTAMASS:226.058972	C9 H10 N2 O5	uh3po4	\N	\N
135	Methylation (D)	:SYMBOLEXT:me;MODIFIED:D;DELTAMASS:14.015650	H2 C	me	\N	\N
\.


--
-- Name: modification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: myXi3_user
--

SELECT pg_catalog.setval('modification_id_seq', 134, true);


--
-- Data for Name: user_groups; Type: TABLE DATA; Schema: public; Owner: myXi3_user
--

COPY user_groups (id, name, max_search_count, max_spectra, max_aas, search_lifetime_days, super_user, see_all, can_add_search, max_searches_per_day) FROM stdin;
14	past_student	100	10000000	100000	1000	f	f	f	0
13	reader	0	100000000	100000	10000	f	t	f	0
6	past_member	10000	100000000	1000000	10000	f	f	f	0
2	student	100	1000000000	100000	10000	f	f	t	10
1	internal	10000	2000000000	1000000	10000	f	t	t	100
12	awaiting_approval	0	100000	2000	366	f	f	f	0
5	administrator	10000	1000000000	1000000	10000	t	t	t	100
11	external_member	10	100000	2000	366	f	f	t	1
\.


--
-- Name: user_groups_id; Type: SEQUENCE SET; Schema: public; Owner: myXi3_user
--

SELECT pg_catalog.setval('user_groups_id', 10, true);


--
-- Name: base_setting_name_key; Type: CONSTRAINT; Schema: public; Owner: myXi3_user; Tablespace: 
--

ALTER TABLE ONLY base_setting
    ADD CONSTRAINT base_setting_name_key UNIQUE (name);


--
-- Name: base_setting_pkey; Type: CONSTRAINT; Schema: public; Owner: myXi3_user; Tablespace: 
--

ALTER TABLE ONLY base_setting
    ADD CONSTRAINT base_setting_pkey PRIMARY KEY (id);


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
-- Name: loss_pkey; Type: CONSTRAINT; Schema: public; Owner: myXi3_user; Tablespace: 
--

ALTER TABLE ONLY loss
    ADD CONSTRAINT loss_pkey PRIMARY KEY (id);


--
-- Name: match_type_pkey; Type: CONSTRAINT; Schema: public; Owner: myXi3_user; Tablespace: 
--

ALTER TABLE ONLY match_type
    ADD CONSTRAINT match_type_pkey PRIMARY KEY (id);


--
-- Name: modification_pkey; Type: CONSTRAINT; Schema: public; Owner: myXi3_user; Tablespace: 
--

ALTER TABLE ONLY modification
    ADD CONSTRAINT modification_pkey PRIMARY KEY (id);


--
-- Name: user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: myXi3_user; Tablespace: 
--

ALTER TABLE ONLY user_groups
    ADD CONSTRAINT user_groups_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

