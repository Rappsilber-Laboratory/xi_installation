--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner:
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: comma_concate(text, text); Type: FUNCTION; Schema: public; Owner: myXi3_user
--

CREATE FUNCTION comma_concate(text, text) RETURNS text
    LANGUAGE plpgsql
    AS $_$
  DECLARE
    t text;
  BEGIN
    IF  character_length($1) > 0 THEN
      t = $1 ||', '|| $2;
    ELSE
      t = $2;
    END IF;
    RETURN t;
  END;

  $_$;


ALTER FUNCTION public.comma_concate(text, text) OWNER TO myXi3_user;

--
-- Name: f_export(integer); Type: FUNCTION; Schema: public; Owner: myXi3_user
--

CREATE FUNCTION f_export(sid integer) RETURNS TABLE(search_id integer, spectrum_match_id bigint, spectrum_id bigint, notes text, autovalidated boolean, rejected boolean, validated character varying, rank integer, run_name character varying, scan_number integer, match_score numeric, total_fragment_matches smallint, delta real, peptide1_coverage smallint, peptide2_coverage smallint, spectrum_peaks_coverage real, spectrum_intensity_coverage real, peptide1_id bigint, peptide1 text, protein1 text[], peptide_position1 integer[], site_count1 integer, protein_count1 integer, pep1_link_pos integer, peptide1_length integer, peptide2_id bigint, peptide2 text, protein2 text[], peptide_position2 integer[], site_count2 integer, protein_count2 integer, pep2_link_pos integer, peptide2_length integer, crosslinker character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
   RETURN QUERY

   SELECT
    sm.search_id,
    sm.id as spectrum_match_id,
    s.id as spectrum_id ,
    sm.notes,
    sm.autovalidated,
    sm.rejected,
    sm.validated,
    sm.rank,
    ss.name AS run_name,
    s.scan_number,
    sm.score AS match_score,
    scorefragmentsmatchedconservative AS total_fragment_matches,
    scoredelta AS delta,
    scorepeptide1matchedconservative AS peptide1_coverage,
    scorepeptide2matchedconservative AS peptide2_coverage,
    scorespectrumpeaksexplained AS spectrum_peaks_coverage,
    scorespectrumintensityexplained AS spectrum_intensity_coverage,
    mp1.peptide_id AS peptide1_id,
    mp1.sequence AS peptide1,
    mp1.protein_names as protein1,
    mp1.peptide_positions as peptide_position1,
    mp1.site_count AS site_count1,
    mp1.protein_count AS protein_count1,
    mp1.link_position AS pep1_link_pos,
    mp1.peptide_length AS peptide1_length,
    mp2.peptide_id AS peptide2_id,
    mp2.sequence AS peptide2,
    mp2.protein_names as protein2,
    mp2.peptide_positions as peptide_position2,
    mp2.site_count as site_count2,
    mp2.protein_count as protein_count2,
    mp2.link_position AS pep2_link_pos,
    mp2.peptide_length AS peptide2_length,
    cl.name AS crosslinker

FROM
    (SELECT * FROM Spectrum_match smi WHERE smi.search_id = sid AND smi.dynamic_rank = 't') sm
        INNER JOIN
    f_matched_proteins(10001,1) mp1
        ON sm.id = mp1.match_id
        LEFT OUTER JOIN
    f_matched_proteins(10001,2) mp2
        ON sm.id = mp2.match_id
        INNER JOIN
    spectrum s
        ON sm.spectrum_id = s.id
        INNER JOIN
    spectrum_source ss
        ON s.source_id = ss.id
        LEFT OUTER JOIN
    crosslinker cl
        ON mp2.crosslinker_id = cl.id;


END
$$;


ALTER FUNCTION public.f_export(sid integer) OWNER TO myXi3_user;

--
-- Name: f_export(integer, boolean); Type: FUNCTION; Schema: public; Owner: myXi3_user
--

CREATE FUNCTION f_export(sid integer, dynamicrank boolean) RETURNS TABLE(search_id integer, spectrum_match_id bigint, spectrum_id bigint, notes text, autovalidated boolean, rejected boolean, validated character varying, rank integer, run_name character varying, scan_number integer, match_score numeric, total_fragment_matches smallint, delta real, peptide1_coverage smallint, peptide2_coverage smallint, spectrum_peaks_coverage real, spectrum_intensity_coverage real, peptide1_id bigint, peptide1 text, protein1 text[], peptide_position1 integer[], site_count1 integer, protein_count1 integer, pep1_link_pos integer, peptide1_length integer, peptide2_id bigint, peptide2 text, protein2 text[], peptide_position2 integer[], site_count2 integer, protein_count2 integer, pep2_link_pos integer, peptide2_length integer, crosslinker character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN

   IF not dynamicrank ISNULL THEN
       RETURN QUERY
       SELECT
        sm.search_id,
        sm.id as spectrum_match_id,
        s.id as spectrum_id ,
        sm.notes,
        sm.autovalidated,
        sm.rejected,
        sm.validated,
        sm.rank,
        ss.name AS run_name,
        s.scan_number,
        sm.score AS match_score,
        scorefragmentsmatchedconservative AS total_fragment_matches,
        scoredelta AS delta,
        scorepeptide1matchedconservative AS peptide1_coverage,
        scorepeptide2matchedconservative AS peptide2_coverage,
        scorespectrumpeaksexplained AS spectrum_peaks_coverage,
        scorespectrumintensityexplained AS spectrum_intensity_coverage,
        mp1.peptide_id AS peptide1_id,
        mp1.sequence AS peptide1,
        mp1.protein_names as protein1,
        mp1.peptide_positions as peptide_position1,
        mp1.site_count AS site_count1,
        mp1.protein_count AS protein_count1,
        mp1.link_position AS pep1_link_pos,
        mp1.peptide_length AS peptide1_length,
        mp2.peptide_id AS peptide2_id,
        mp2.sequence AS peptide2,
        mp2.protein_names as protein2,
        mp2.peptide_positions as peptide_position2,
        mp2.site_count as site_count2,
        mp2.protein_count as protein_count2,
        mp2.link_position AS pep2_link_pos,
        mp2.peptide_length AS peptide2_length,
        cl.name AS crosslinker

    FROM
        (SELECT * FROM Spectrum_match smi WHERE smi.search_id = sid AND smi.dynamic_rank = dynamicrank) sm
            INNER JOIN
        f_matched_proteins(sid,1) mp1
            ON sm.id = mp1.match_id
            LEFT OUTER JOIN
        f_matched_proteins(sid,2) mp2
            ON sm.id = mp2.match_id
            INNER JOIN
        spectrum s
            ON sm.spectrum_id = s.id
            INNER JOIN
        spectrum_source ss
            ON s.source_id = ss.id
            LEFT OUTER JOIN
        crosslinker cl
            ON mp2.crosslinker_id = cl.id;
  ELSE
       RETURN QUERY
       SELECT
        sm.search_id,
        sm.id as spectrum_match_id,
        s.id as spectrum_id ,
        sm.notes,
        sm.autovalidated,
        sm.rejected,
        sm.validated,
        sm.rank,
        ss.name AS run_name,
        s.scan_number,
        sm.score AS match_score,
        scorefragmentsmatchedconservative AS total_fragment_matches,
        scoredelta AS delta,
        scorepeptide1matchedconservative AS peptide1_coverage,
        scorepeptide2matchedconservative AS peptide2_coverage,
        scorespectrumpeaksexplained AS spectrum_peaks_coverage,
        scorespectrumintensityexplained AS spectrum_intensity_coverage,
        mp1.peptide_id AS peptide1_id,
        mp1.sequence AS peptide1,
        mp1.protein_names as protein1,
        mp1.peptide_positions as peptide_position1,
        mp1.site_count AS site_count1,
        mp1.protein_count AS protein_count1,
        mp1.link_position AS pep1_link_pos,
        mp1.peptide_length AS peptide1_length,
        mp2.peptide_id AS peptide2_id,
        mp2.sequence AS peptide2,
        mp2.protein_names as protein2,
        mp2.peptide_positions as peptide_position2,
        mp2.site_count as site_count2,
        mp2.protein_count as protein_count2,
        mp2.link_position AS pep2_link_pos,
        mp2.peptide_length AS peptide2_length,
        cl.name AS crosslinker

    FROM
        (SELECT * FROM Spectrum_match smi WHERE smi.search_id = sid) sm
            INNER JOIN
        f_matched_proteins(sid,1) mp1
            ON sm.id = mp1.match_id
            LEFT OUTER JOIN
        f_matched_proteins(sid,2) mp2
            ON sm.id = mp2.match_id
            INNER JOIN
        spectrum s
            ON sm.spectrum_id = s.id
            INNER JOIN
        spectrum_source ss
            ON s.source_id = ss.id
            LEFT OUTER JOIN
        crosslinker cl
            ON mp2.crosslinker_id = cl.id;

  END IF;


END
$$;


ALTER FUNCTION public.f_export(sid integer, dynamicrank boolean) OWNER TO myXi3_user;

--
-- Name: f_matched_proteins(integer, integer); Type: FUNCTION; Schema: public; Owner: myXi3_user
--

CREATE FUNCTION f_matched_proteins(sid integer, matchtype integer) RETURNS TABLE(match_id bigint, link_position integer, crosslinker_id integer, crosslinker_number integer, peptide_id bigint, sequence text, peptide_length integer, protein_ids bigint[], protein_names text[], peptide_positions integer[], unique_proteins text[], site_count integer, protein_count integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
   RETURN QUERY
   SELECT *,array_length(i.peptide_positions,1) as site_count,array_length(i.unique_proteins,1) as protein_count     from (
   SELECT
    mp.match_id,
    mp.link_position,
    mp.crosslinker_id,
    mp.crosslinker_number,
    pep.id as peptide_id,
    pep.sequence,
    pep.peptide_length,
    array_agg(pr.id) AS protein_ids,
    array_agg(pr.name) AS protein_names,
    array_agg(hp.peptide_position) as peptide_positions,
    array_agg(distinct pr.name) AS unique_proteins
   FROM
    (Select * from matched_peptide where search_id = sid AND match_type = matchtype) mp
        INNER JOIN
    peptide pep
        ON mp.peptide_id = pep.id
        INNER JOIN
    has_protein hp
        ON mp.peptide_id = hp.peptide_id
        INNER JOIN
    protein pr
        ON hp.protein_id = pr.id
   GROUP BY mp.match_id,mp.link_position,mp.crosslinker_id, mp.crosslinker_number,  pep.id, pep.peptide_length, pep.sequence
   ) i;
END
$$;


ALTER FUNCTION public.f_matched_proteins(sid integer, matchtype integer) OWNER TO myXi3_user;

--
-- Name: randomstring(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION randomstring() RETURNS character varying
    LANGUAGE sql
    AS $$
 SELECT
         CAST( '' || trunc(random()*10) ||  trunc(random()*10) || trunc(random()*10) || trunc(random()*10) || trunc(random()*10)
           || '-' || trunc(random()*10) || trunc(random()*10) || trunc(random()*10) || trunc(random()*10) || trunc(random()*10)
           || '-' || trunc(random()*10) || trunc(random()*10) || trunc(random()*10) || trunc(random()*10) || trunc(random()*10)
           || '-' || trunc(random()*10) || trunc(random()*10) || trunc(random()*10) || trunc(random()*10) || trunc(random()*10)
             AS varchar)
 $$;


ALTER FUNCTION public.randomstring() OWNER TO postgres;

--
-- Name: reserve_ids(character varying, bigint); Type: FUNCTION; Schema: public; Owner: myXi3_user
--

CREATE FUNCTION reserve_ids(sequence_name character varying, count bigint DEFAULT 1) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE
    val BIGINT;
BEGIN
    UPDATE storage_ids
    SET id_value = id_value + count
    WHERE name = sequence_name
    RETURNING id_value INTO val;
    RETURN val-count;
END;
$$;


ALTER FUNCTION public.reserve_ids(sequence_name character varying, count bigint) OWNER TO myXi3_user;

--
-- Name: FUNCTION reserve_ids(sequence_name character varying, count bigint); Type: COMMENT; Schema: public; Owner: myXi3_user
--

COMMENT ON FUNCTION reserve_ids(sequence_name character varying, count bigint) IS 'reserves a set of ids for a given name';


--
-- Name: reserve_ids2(character varying, bigint); Type: FUNCTION; Schema: public; Owner: myXi3_user
--

CREATE FUNCTION reserve_ids2(sequence_name character varying, count bigint DEFAULT 1) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE
    val BIGINT;
BEGIN
    SELECT id_value INTO val FROM storage_ids WHERE name = sequence_name FOR UPDATE;
    UPDATE storage_ids
    SET id_value = val + count
    WHERE name = sequence_name;
    RETURN val;
END;
$$;


ALTER FUNCTION public.reserve_ids2(sequence_name character varying, count bigint) OWNER TO myXi3_user;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: acquisition; Type: TABLE; Schema: public; Owner: myXi3_user; Tablespace:
--

CREATE TABLE acquisition (
    id integer NOT NULL,
    name character varying(1000),
    notes character varying(10000),
    upload_date timestamp without time zone DEFAULT now(),
    uploadedby integer,
    private boolean DEFAULT false,
    file_path character varying(10000)[]
);


ALTER TABLE acquisition OWNER TO myXi3_user;

--
-- Name: acquisition_id; Type: SEQUENCE; Schema: public; Owner: myXi3_user
--

CREATE SEQUENCE acquisition_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE acquisition_id OWNER TO myXi3_user;

--
-- Name: acquisition_id; Type: SEQUENCE OWNED BY; Schema: public; Owner: myXi3_user
--

ALTER SEQUENCE acquisition_id OWNED BY acquisition.id;


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
-- Name: chosen_crosslinker; Type: TABLE; Schema: public; Owner: myXi3_user; Tablespace:
--

CREATE TABLE chosen_crosslinker (
    paramset_id integer NOT NULL,
    crosslinker_id integer NOT NULL
);


ALTER TABLE chosen_crosslinker OWNER TO myXi3_user;

--
-- Name: chosen_ions; Type: TABLE; Schema: public; Owner: myXi3_user; Tablespace:
--

CREATE TABLE chosen_ions (
    paramset_id integer NOT NULL,
    ion_id integer NOT NULL
);


ALTER TABLE chosen_ions OWNER TO myXi3_user;

--
-- Name: chosen_label_scheme; Type: TABLE; Schema: public; Owner: myXi3_user; Tablespace:
--

CREATE TABLE chosen_label_scheme (
    paramset_id integer NOT NULL,
    scheme_id integer NOT NULL,
    label_id integer NOT NULL
);


ALTER TABLE chosen_label_scheme OWNER TO myXi3_user;

--
-- Name: chosen_losses; Type: TABLE; Schema: public; Owner: myXi3_user; Tablespace:
--

CREATE TABLE chosen_losses (
    paramset_id integer NOT NULL,
    loss_id integer NOT NULL
);


ALTER TABLE chosen_losses OWNER TO myXi3_user;

--
-- Name: chosen_modification; Type: TABLE; Schema: public; Owner: myXi3_user; Tablespace:
--

CREATE TABLE chosen_modification (
    paramset_id integer NOT NULL,
    mod_id integer NOT NULL,
    fixed boolean NOT NULL
);


ALTER TABLE chosen_modification OWNER TO myXi3_user;

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
-- Name: fdrlevel; Type: TABLE; Schema: public; Owner: myXi3_user; Tablespace:
--

CREATE TABLE fdrlevel (
    level_id integer NOT NULL,
    name character varying(100)
);


ALTER TABLE fdrlevel OWNER TO myXi3_user;

--
-- Name: has_protein; Type: TABLE; Schema: public; Owner: myXi3_user; Tablespace:
--

CREATE TABLE has_protein (
    peptide_id bigint NOT NULL,
    protein_id bigint NOT NULL,
    peptide_position integer NOT NULL,
    display_site boolean
);


ALTER TABLE has_protein OWNER TO myXi3_user;

--
-- Name: ion; Type: TABLE; Schema: public; Owner: myXi3_user; Tablespace:
--

CREATE TABLE ion (
    id integer NOT NULL,
    name character varying(50),
    description text,
    is_default boolean
);


ALTER TABLE ion OWNER TO myXi3_user;

--
-- Name: COLUMN ion.is_default; Type: COMMENT; Schema: public; Owner: myXi3_user
--

COMMENT ON COLUMN ion.is_default IS 'Is an ion chosen by default?';


--
-- Name: ion_id_seq; Type: SEQUENCE; Schema: public; Owner: myXi3_user
--

CREATE SEQUENCE ion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ion_id_seq OWNER TO myXi3_user;

--
-- Name: ion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: myXi3_user
--

ALTER SEQUENCE ion_id_seq OWNED BY ion.id;


--
-- Name: label; Type: TABLE; Schema: public; Owner: myXi3_user; Tablespace:
--

CREATE TABLE label (
    id integer NOT NULL,
    name character varying(1000),
    aa character varying(10),
    description text
);


ALTER TABLE label OWNER TO myXi3_user;

--
-- Name: label_id_seq; Type: SEQUENCE; Schema: public; Owner: myXi3_user
--

CREATE SEQUENCE label_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE label_id_seq OWNER TO myXi3_user;

--
-- Name: label_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: myXi3_user
--

ALTER SEQUENCE label_id_seq OWNED BY label.id;


--
-- Name: label_scheme; Type: TABLE; Schema: public; Owner: myXi3_user; Tablespace:
--

CREATE TABLE label_scheme (
    id integer NOT NULL,
    name name
);


ALTER TABLE label_scheme OWNER TO myXi3_user;

--
-- Name: label_scheme_id_seq; Type: SEQUENCE; Schema: public; Owner: myXi3_user
--

CREATE SEQUENCE label_scheme_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE label_scheme_id_seq OWNER TO myXi3_user;

--
-- Name: label_scheme_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: myXi3_user
--

ALTER SEQUENCE label_scheme_id_seq OWNED BY label_scheme.id;


--
-- Name: layouts; Type: TABLE; Schema: public; Owner: myXi3_user; Tablespace:
--

CREATE TABLE layouts (
    search_id text NOT NULL,
    user_id integer NOT NULL,
    "time" timestamp without time zone DEFAULT now() NOT NULL,
    layout text,
    description text
);


ALTER TABLE layouts OWNER TO myXi3_user;

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
-- Name: manual_annotations; Type: TABLE; Schema: public; Owner: myXi3_user; Tablespace:
--

CREATE TABLE manual_annotations (
    protein_ids character varying,
    on_chromatin character(3),
    localization character varying,
    p_function character varying,
    name character varying,
    complex character varying,
    domain_accessions character varying
);


ALTER TABLE manual_annotations OWNER TO myXi3_user;

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
-- Name: matched_peptide; Type: TABLE; Schema: public; Owner: myXi3_user; Tablespace:
--

CREATE TABLE matched_peptide (
    peptide_id bigint NOT NULL,
    match_id bigint NOT NULL,
    match_type integer NOT NULL,
    link_position integer NOT NULL,
    display_positon boolean,
    search_id integer,
    crosslinker_id integer,
    crosslinker_number integer
);


ALTER TABLE matched_peptide OWNER TO myXi3_user;

--
-- Name: COLUMN matched_peptide.crosslinker_id; Type: COMMENT; Schema: public; Owner: myXi3_user
--

COMMENT ON COLUMN matched_peptide.crosslinker_id IS 'Which of the n involved crosslinker is linking to the refered site';


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
-- Name: parameter_set; Type: TABLE; Schema: public; Owner: myXi3_user; Tablespace:
--

CREATE TABLE parameter_set (
    id integer NOT NULL,
    name character varying(1000),
    template boolean,
    uploadedby integer,
    top_alpha_matches integer,
    missed_cleavages integer,
    ms_tol numeric,
    ms2_tol numeric,
    ms_tol_unit character varying(10),
    ms2_tol_unit character varying(10),
    synthetic boolean,
    global_id uuid,
    upload_date timestamp without time zone DEFAULT now(),
    enzyme_chosen integer,
    notes character varying(10000),
    customsettings character varying(50000)
);


ALTER TABLE parameter_set OWNER TO myXi3_user;

--
-- Name: search; Type: TABLE; Schema: public; Owner: myXi3_user; Tablespace:
--

CREATE TABLE search (
    id integer NOT NULL,
    name character varying(1000),
    private boolean DEFAULT false,
    uploadedby integer,
    paramset_id integer,
    submit_date timestamp without time zone DEFAULT now(),
    notes character varying(10000),
    status character varying(1000),
    percent_complete integer,
    completed boolean,
    is_executing boolean,
    hidden boolean,
    total_spec_count integer,
    total_proteins integer,
    total_peptides integer,
    visible_group integer DEFAULT 1,
    random_id character varying(100) DEFAULT randomstring() NOT NULL,
    cleanup boolean DEFAULT false,
    r_flag boolean DEFAULT false
);


ALTER TABLE search OWNER TO myXi3_user;

--
-- Name: users; Type: TABLE; Schema: public; Owner: myXi3_user; Tablespace:
--

CREATE TABLE users (
    id integer NOT NULL,
    user_name character varying(20) NOT NULL,
    password text,
    max_spectra integer,
    max_aas integer,
    email character varying(320),
    ptoken_timestamp timestamp with time zone,
    super_user boolean,
    ptoken character varying(36)
);


ALTER TABLE users OWNER TO myXi3_user;

--
-- Name: COLUMN users.email; Type: COMMENT; Schema: public; Owner: myXi3_user
--

COMMENT ON COLUMN users.email IS 'Varchar 320';


--
-- Name: COLUMN users.ptoken_timestamp; Type: COMMENT; Schema: public; Owner: myXi3_user
--

COMMENT ON COLUMN users.ptoken_timestamp IS 'timestamp that puts limit on when password can be reset';


--
-- Name: COLUMN users.ptoken; Type: COMMENT; Schema: public; Owner: myXi3_user
--

COMMENT ON COLUMN users.ptoken IS 'token for authenticating user in web link';


--
-- Name: opentargetmodificationsearches; Type: VIEW; Schema: public; Owner: myXi3_user
--

CREATE VIEW opentargetmodificationsearches AS
 SELECT s.id,
    s.name,
    s.private,
    u.user_name,
    s.paramset_id,
    s.submit_date,
    s.notes,
    s.status,
    s.percent_complete,
    s.completed,
    s.is_executing,
    s.hidden,
    s.total_spec_count,
    s.total_proteins,
    s.total_peptides,
    s.visible_group,
    s.random_id,
    s.cleanup
   FROM ((((search s
     JOIN parameter_set ps ON ((s.paramset_id = ps.id)))
     JOIN chosen_crosslinker cc ON ((cc.paramset_id = ps.id)))
     JOIN crosslinker c ON ((cc.crosslinker_id = c.id)))
     JOIN users u ON ((s.uploadedby = u.id)))
  WHERE (((lower((c.name)::text) ~~ 'openmodification'::text) OR (lower((c.name)::text) ~~ 'targetmodification'::text)) AND ((s.status)::text <> 'failed'::text));


ALTER TABLE opentargetmodificationsearches OWNER TO myXi3_user;

--
-- Name: parameter_set_id; Type: SEQUENCE; Schema: public; Owner: myXi3_user
--

CREATE SEQUENCE parameter_set_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE parameter_set_id OWNER TO myXi3_user;

--
-- Name: parameter_set_id; Type: SEQUENCE OWNED BY; Schema: public; Owner: myXi3_user
--

ALTER SEQUENCE parameter_set_id OWNED BY parameter_set.id;


--
-- Name: peptide; Type: TABLE; Schema: public; Owner: myXi3_user; Tablespace:
--

CREATE TABLE peptide (
    id bigint NOT NULL,
    sequence text,
    mass numeric,
    peptide_length integer
);


ALTER TABLE peptide OWNER TO myXi3_user;

--
-- Name: protein; Type: TABLE; Schema: public; Owner: myXi3_user; Tablespace:
--

CREATE TABLE protein (
    id bigint NOT NULL,
    name text,
    accession_number text,
    description text,
    sequence text,
    is_decoy boolean DEFAULT false,
    protein_length integer,
    header text
);


ALTER TABLE protein OWNER TO myXi3_user;

--
-- Name: run; Type: TABLE; Schema: public; Owner: myXi3_user; Tablespace:
--

CREATE TABLE run (
    acq_id integer NOT NULL,
    run_id integer NOT NULL,
    name character varying(1000),
    file_path character varying(10000),
    size character varying(50)[]
);


ALTER TABLE run OWNER TO myXi3_user;

--
-- Name: score_id_seq; Type: SEQUENCE; Schema: public; Owner: myXi3_user
--

CREATE SEQUENCE score_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE score_id_seq OWNER TO myXi3_user;

--
-- Name: search_acquisition; Type: TABLE; Schema: public; Owner: myXi3_user; Tablespace:
--

CREATE TABLE search_acquisition (
    search_id integer NOT NULL,
    acq_id integer NOT NULL,
    run_id integer NOT NULL
);


ALTER TABLE search_acquisition OWNER TO myXi3_user;

--
-- Name: search_id; Type: SEQUENCE; Schema: public; Owner: myXi3_user
--

CREATE SEQUENCE search_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE search_id OWNER TO myXi3_user;

--
-- Name: search_id; Type: SEQUENCE OWNED BY; Schema: public; Owner: myXi3_user
--

ALTER SEQUENCE search_id OWNED BY search.id;


--
-- Name: search_sequencedb; Type: TABLE; Schema: public; Owner: myXi3_user; Tablespace:
--

CREATE TABLE search_sequencedb (
    search_id integer NOT NULL,
    seqdb_id integer NOT NULL
);


ALTER TABLE search_sequencedb OWNER TO myXi3_user;

--
-- Name: sequence_file; Type: TABLE; Schema: public; Owner: myXi3_user; Tablespace:
--

CREATE TABLE sequence_file (
    id integer NOT NULL,
    name character varying(1000),
    file_name character varying(10000),
    decoy_file boolean DEFAULT false,
    file_path character varying(10000),
    notes character varying(10000),
    upload_date timestamp without time zone DEFAULT now(),
    uploadedby integer,
    private boolean DEFAULT false,
    species character varying(40)
);


ALTER TABLE sequence_file OWNER TO myXi3_user;

--
-- Name: sequence_file_id; Type: SEQUENCE; Schema: public; Owner: myXi3_user
--

CREATE SEQUENCE sequence_file_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sequence_file_id OWNER TO myXi3_user;

--
-- Name: sequence_file_id; Type: SEQUENCE OWNED BY; Schema: public; Owner: myXi3_user
--

ALTER SEQUENCE sequence_file_id OWNED BY sequence_file.id;


--
-- Name: spectrum; Type: TABLE; Schema: public; Owner: myXi3_user; Tablespace:
--

CREATE TABLE spectrum (
    id bigint NOT NULL,
    run_id integer,
    acq_id integer,
    scan_number integer,
    elution_time_start character varying(50),
    elution_time_end character varying(50),
    precursor_charge integer,
    precursor_intensity numeric,
    precursor_mz numeric,
    notes text,
    source_id integer
);


ALTER TABLE spectrum OWNER TO myXi3_user;

--
-- Name: spectrum_match; Type: TABLE; Schema: public; Owner: myXi3_user; Tablespace:
--

CREATE TABLE spectrum_match (
    id bigint NOT NULL,
    spectrum_id bigint,
    search_id integer,
    rank integer,
    validation_id integer,
    is_decoy boolean DEFAULT false,
    score numeric,
    precursor_charge integer,
    calc_mass numeric,
    notes text,
    autovalidated boolean,
    rejected boolean,
    validated character varying(5),
    dynamic_rank boolean,
    percentdecoy double precision,
    rescored double precision,
    scorepeptide1matchedconservative smallint,
    scorepeptide2matchedconservative smallint,
    scorefragmentsmatchedconservative smallint,
    scorespectrumpeaksexplained real,
    scorespectrumintensityexplained real,
    scorelinksitedelta real,
    scoredelta real,
    scoremoddelta real,
    scoremgxrank smallint,
    scoremgcalpha real,
    scoremgcbeta real,
    scoremgc real,
    scoremgx real,
    scoremgxdelta real
);


ALTER TABLE spectrum_match OWNER TO myXi3_user;

--
-- Name: spectrum_peak; Type: TABLE; Schema: public; Owner: myXi3_user; Tablespace:
--

CREATE TABLE spectrum_peak (
    id bigint NOT NULL,
    spectrum_id bigint,
    mz numeric,
    intensity numeric,
    ismonoisotope boolean,
    isisotope boolean
);


ALTER TABLE spectrum_peak OWNER TO myXi3_user;

--
-- Name: spectrum_source; Type: TABLE; Schema: public; Owner: myXi3_user; Tablespace:
--

CREATE TABLE spectrum_source (
    id integer NOT NULL,
    name character varying
);


ALTER TABLE spectrum_source OWNER TO myXi3_user;

--
-- Name: spectrum_source_id_seq; Type: SEQUENCE; Schema: public; Owner: myXi3_user
--

CREATE SEQUENCE spectrum_source_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE spectrum_source_id_seq OWNER TO myXi3_user;

--
-- Name: spectrum_source_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: myXi3_user
--

ALTER SEQUENCE spectrum_source_id_seq OWNED BY spectrum_source.id;


--
-- Name: storage_ids; Type: TABLE; Schema: public; Owner: myXi3_user; Tablespace:
--

CREATE TABLE storage_ids (
    name character varying(200) NOT NULL,
    id_value bigint
);


ALTER TABLE storage_ids OWNER TO myXi3_user;

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
-- Name: user_in_group; Type: TABLE; Schema: public; Owner: myXi3_user; Tablespace:
--

CREATE TABLE user_in_group (
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE user_in_group OWNER TO myXi3_user;

--
-- Name: users_id; Type: SEQUENCE; Schema: public; Owner: myXi3_user
--

CREATE SEQUENCE users_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_id OWNER TO myXi3_user;

--
-- Name: users_id; Type: SEQUENCE OWNED BY; Schema: public; Owner: myXi3_user
--

ALTER SEQUENCE users_id OWNED BY users.id;


--
-- Name: v_gettablesizes; Type: VIEW; Schema: public; Owner: myXi3_user
--

CREATE VIEW v_gettablesizes AS
 SELECT (((n.nspname)::text || '.'::text) || (c.relname)::text) AS relation,
    pg_size_pretty(pg_relation_size((c.oid)::regclass)) AS size
   FROM (pg_class c
     LEFT JOIN pg_namespace n ON ((n.oid = c.relnamespace)))
  WHERE (n.nspname <> ALL (ARRAY['pg_catalog'::name, 'information_schema'::name]))
  ORDER BY pg_relation_size((c.oid)::regclass) DESC;


ALTER TABLE v_gettablesizes OWNER TO myXi3_user;

--
-- Name: version_number; Type: TABLE; Schema: public; Owner: myXi3_user; Tablespace:
--

CREATE TABLE version_number (
    component character varying(100),
    version_upper integer,
    version_lower integer,
    version_internal integer,
    description text,
    directory_path text,
    current boolean,
    date timestamp without time zone DEFAULT now()
);


ALTER TABLE version_number OWNER TO myXi3_user;

--
-- Name: xi_config; Type: VIEW; Schema: public; Owner: myXi3_user
--

CREATE VIEW xi_config AS
 SELECT s.search_id,
    s.description
   FROM ( SELECT 80 AS o,
            s_1.id AS search_id,
            ('custom:'::text || (ps.customsettings)::text) AS description
           FROM (search s_1
             JOIN parameter_set ps ON ((s_1.paramset_id = ps.id)))
          WHERE (ps.customsettings IS NOT NULL)
        UNION
         SELECT 20 AS o,
            s_1.id AS search_id,
            ((c.description || ';id:'::text) || c.id) AS description
           FROM ((search s_1
             JOIN chosen_crosslinker cc ON ((cc.paramset_id = s_1.paramset_id)))
             JOIN crosslinker c ON ((cc.crosslinker_id = c.id)))
        UNION
         SELECT 30 AS o,
            s_1.id AS search_id,
            ((i.description || ';id:'::text) || i.id) AS description
           FROM ((search s_1
             JOIN chosen_ions ci ON ((ci.paramset_id = s_1.paramset_id)))
             JOIN ion i ON ((ci.ion_id = i.id)))
        UNION
         SELECT 10 AS o,
            s_1.id AS search_id,
            ('modification:fixed:'::text || m.description) AS description
           FROM ((search s_1
             LEFT JOIN chosen_modification cm ON ((cm.paramset_id = s_1.paramset_id)))
             JOIN modification m ON ((m.id = cm.mod_id)))
          WHERE (cm.fixed = true)
        UNION
         SELECT 10 AS o,
            s_1.id AS search_id,
            ('modification:variable:'::text || m.description) AS description
           FROM ((search s_1
             JOIN chosen_modification cm ON ((cm.paramset_id = s_1.paramset_id)))
             JOIN modification m ON ((m.id = cm.mod_id)))
          WHERE (cm.fixed = false)
        UNION
         SELECT 10 AS o,
            s_1.id AS search_id,
            ('modification:known:'::text || m.description) AS description
           FROM search s_1,
            modification m
          WHERE (NOT (m.id IN ( SELECT chosen_modification.mod_id
                   FROM chosen_modification
                  WHERE (chosen_modification.paramset_id = s_1.paramset_id))))
        UNION
         SELECT 40 AS o,
            s_1.id AS search_id,
            ((l.description || ';id:'::text) || l.id) AS description
           FROM ((search s_1
             JOIN chosen_losses cl ON ((cl.paramset_id = s_1.paramset_id)))
             JOIN loss l ON ((cl.loss_id = l.id)))
        UNION
         SELECT 20 AS o,
            s_1.id AS search_id,
            ('label:heavy:'::text || label.description) AS description
           FROM ((search s_1
             JOIN chosen_label_scheme cl ON ((cl.paramset_id = s_1.paramset_id)))
             JOIN label label ON ((label.id = cl.label_id)))
          WHERE (cl.scheme_id = 1)
        UNION
         SELECT 20 AS o,
            s_1.id AS search_id,
            ('label:medium:'::text || label.description) AS description
           FROM ((search s_1
             JOIN chosen_label_scheme cl ON ((cl.paramset_id = s_1.paramset_id)))
             JOIN label label ON ((label.id = cl.label_id)))
          WHERE (cl.scheme_id = 2)
        UNION
         SELECT 90 AS o,
            s_1.id AS search_id,
            e.description
           FROM ((search s_1
             JOIN parameter_set ps ON ((s_1.paramset_id = ps.id)))
             JOIN enzyme e ON ((ps.enzyme_chosen = e.id)))
        UNION
         SELECT 80 AS o,
            s_1.id AS search_id,
            (('tolerance:precursor:'::text || ps.ms_tol) || (ps.ms_tol_unit)::text) AS description
           FROM (search s_1
             JOIN parameter_set ps ON ((s_1.paramset_id = ps.id)))
        UNION
         SELECT 80 AS o,
            s_1.id AS search_id,
            (('tolerance:fragment:'::text || ps.ms2_tol) || (ps.ms2_tol_unit)::text) AS description
           FROM (search s_1
             JOIN parameter_set ps ON ((s_1.paramset_id = ps.id)))
        UNION
         SELECT 80 AS o,
            s_1.id AS search_id,
            ('missedcleavages:'::text || ps.missed_cleavages) AS description
           FROM (search s_1
             JOIN parameter_set ps ON ((s_1.paramset_id = ps.id)))
        UNION
         SELECT 80 AS o,
            s_1.id AS search_id,
            ('topmgchits:'::text || ps.top_alpha_matches) AS description
           FROM (search s_1
             JOIN parameter_set ps ON ((s_1.paramset_id = ps.id)))
        UNION
         SELECT 100 AS o,
            s_1.id AS search_id,
            ('synthetic:'::text || ps.synthetic) AS description
           FROM (search s_1
             JOIN parameter_set ps ON ((s_1.paramset_id = ps.id)))
        UNION
         SELECT 10 AS o,
            (-1) AS search_id,
            (((bs.name)::text || ':'::text) || bs.setting) AS description
           FROM base_setting bs) s
  ORDER BY s.o;


ALTER TABLE xi_config OWNER TO myXi3_user;

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: myXi3_user
--

ALTER TABLE ONLY acquisition ALTER COLUMN id SET DEFAULT nextval('acquisition_id'::regclass);


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

ALTER TABLE ONLY ion ALTER COLUMN id SET DEFAULT nextval('ion_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: myXi3_user
--

ALTER TABLE ONLY label ALTER COLUMN id SET DEFAULT nextval('label_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: myXi3_user
--

ALTER TABLE ONLY label_scheme ALTER COLUMN id SET DEFAULT nextval('label_scheme_id_seq'::regclass);


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

ALTER TABLE ONLY parameter_set ALTER COLUMN id SET DEFAULT nextval('parameter_set_id'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: myXi3_user
--

ALTER TABLE ONLY search ALTER COLUMN id SET DEFAULT nextval('search_id'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: myXi3_user
--

ALTER TABLE ONLY sequence_file ALTER COLUMN id SET DEFAULT nextval('sequence_file_id'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: myXi3_user
--

ALTER TABLE ONLY spectrum_source ALTER COLUMN id SET DEFAULT nextval('spectrum_source_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: myXi3_user
--

ALTER TABLE ONLY user_groups ALTER COLUMN id SET DEFAULT nextval('user_groups_id'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: myXi3_user
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id'::regclass);


--
-- Name: acquisition_pkey; Type: CONSTRAINT; Schema: public; Owner: myXi3_user; Tablespace:
--

ALTER TABLE ONLY acquisition
    ADD CONSTRAINT acquisition_pkey PRIMARY KEY (id);


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
-- Name: chosen_crosslinker_pkey; Type: CONSTRAINT; Schema: public; Owner: myXi3_user; Tablespace:
--

ALTER TABLE ONLY chosen_crosslinker
    ADD CONSTRAINT chosen_crosslinker_pkey PRIMARY KEY (paramset_id, crosslinker_id);


--
-- Name: chosen_ions_pkey; Type: CONSTRAINT; Schema: public; Owner: myXi3_user; Tablespace:
--

ALTER TABLE ONLY chosen_ions
    ADD CONSTRAINT chosen_ions_pkey PRIMARY KEY (paramset_id, ion_id);


--
-- Name: chosen_label_scheme_pkey; Type: CONSTRAINT; Schema: public; Owner: myXi3_user; Tablespace:
--

ALTER TABLE ONLY chosen_label_scheme
    ADD CONSTRAINT chosen_label_scheme_pkey PRIMARY KEY (paramset_id, scheme_id, label_id);


--
-- Name: chosen_losses_pkey; Type: CONSTRAINT; Schema: public; Owner: myXi3_user; Tablespace:
--

ALTER TABLE ONLY chosen_losses
    ADD CONSTRAINT chosen_losses_pkey PRIMARY KEY (paramset_id, loss_id);


--
-- Name: chosen_modification_pkey; Type: CONSTRAINT; Schema: public; Owner: myXi3_user; Tablespace:
--

ALTER TABLE ONLY chosen_modification
    ADD CONSTRAINT chosen_modification_pkey PRIMARY KEY (paramset_id, mod_id, fixed);


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
-- Name: has_protein_pkey; Type: CONSTRAINT; Schema: public; Owner: myXi3_user; Tablespace:
--

ALTER TABLE ONLY has_protein
    ADD CONSTRAINT has_protein_pkey PRIMARY KEY (peptide_id, protein_id, peptide_position);


--
-- Name: ion_pkey; Type: CONSTRAINT; Schema: public; Owner: myXi3_user; Tablespace:
--

ALTER TABLE ONLY ion
    ADD CONSTRAINT ion_pkey PRIMARY KEY (id);


--
-- Name: label_pkey; Type: CONSTRAINT; Schema: public; Owner: myXi3_user; Tablespace:
--

ALTER TABLE ONLY label
    ADD CONSTRAINT label_pkey PRIMARY KEY (id);


--
-- Name: label_scheme_pkey; Type: CONSTRAINT; Schema: public; Owner: myXi3_user; Tablespace:
--

ALTER TABLE ONLY label_scheme
    ADD CONSTRAINT label_scheme_pkey PRIMARY KEY (id);


--
-- Name: layouts_pkey; Type: CONSTRAINT; Schema: public; Owner: myXi3_user; Tablespace:
--

ALTER TABLE ONLY layouts
    ADD CONSTRAINT layouts_pkey PRIMARY KEY (search_id, user_id, "time");


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
-- Name: matched_peptide_pkey; Type: CONSTRAINT; Schema: public; Owner: myXi3_user; Tablespace:
--

ALTER TABLE ONLY matched_peptide
    ADD CONSTRAINT matched_peptide_pkey PRIMARY KEY (match_id, peptide_id, match_type, link_position);


--
-- Name: modification_pkey; Type: CONSTRAINT; Schema: public; Owner: myXi3_user; Tablespace:
--

ALTER TABLE ONLY modification
    ADD CONSTRAINT modification_pkey PRIMARY KEY (id);


--
-- Name: parameter_set_pkey; Type: CONSTRAINT; Schema: public; Owner: myXi3_user; Tablespace:
--

ALTER TABLE ONLY parameter_set
    ADD CONSTRAINT parameter_set_pkey PRIMARY KEY (id);


--
-- Name: peptide_pkey; Type: CONSTRAINT; Schema: public; Owner: myXi3_user; Tablespace:
--

ALTER TABLE ONLY peptide
    ADD CONSTRAINT peptide_pkey PRIMARY KEY (id);


--
-- Name: pk_fdrlevel; Type: CONSTRAINT; Schema: public; Owner: myXi3_user; Tablespace:
--

ALTER TABLE ONLY fdrlevel
    ADD CONSTRAINT pk_fdrlevel PRIMARY KEY (level_id);


--
-- Name: pk_spectrum_source; Type: CONSTRAINT; Schema: public; Owner: myXi3_user; Tablespace:
--

ALTER TABLE ONLY spectrum_source
    ADD CONSTRAINT pk_spectrum_source PRIMARY KEY (id);


--
-- Name: protein_pkey; Type: CONSTRAINT; Schema: public; Owner: myXi3_user; Tablespace:
--

ALTER TABLE ONLY protein
    ADD CONSTRAINT protein_pkey PRIMARY KEY (id);


--
-- Name: run_pkey; Type: CONSTRAINT; Schema: public; Owner: myXi3_user; Tablespace:
--

ALTER TABLE ONLY run
    ADD CONSTRAINT run_pkey PRIMARY KEY (acq_id, run_id);


--
-- Name: search_acquisition_pkey; Type: CONSTRAINT; Schema: public; Owner: myXi3_user; Tablespace:
--

ALTER TABLE ONLY search_acquisition
    ADD CONSTRAINT search_acquisition_pkey PRIMARY KEY (search_id, acq_id, run_id);


--
-- Name: search_pkey; Type: CONSTRAINT; Schema: public; Owner: myXi3_user; Tablespace:
--

ALTER TABLE ONLY search
    ADD CONSTRAINT search_pkey PRIMARY KEY (id);


--
-- Name: search_sequencedb_pkey; Type: CONSTRAINT; Schema: public; Owner: myXi3_user; Tablespace:
--

ALTER TABLE ONLY search_sequencedb
    ADD CONSTRAINT search_sequencedb_pkey PRIMARY KEY (search_id, seqdb_id);


--
-- Name: sequence_file_pkey; Type: CONSTRAINT; Schema: public; Owner: myXi3_user; Tablespace:
--

ALTER TABLE ONLY sequence_file
    ADD CONSTRAINT sequence_file_pkey PRIMARY KEY (id);


--
-- Name: spectrum_match_pkey; Type: CONSTRAINT; Schema: public; Owner: myXi3_user; Tablespace:
--

ALTER TABLE ONLY spectrum_match
    ADD CONSTRAINT spectrum_match_pkey PRIMARY KEY (id);

ALTER TABLE spectrum_match CLUSTER ON spectrum_match_pkey;


--
-- Name: spectrum_peak_pkey; Type: CONSTRAINT; Schema: public; Owner: myXi3_user; Tablespace:
--

ALTER TABLE ONLY spectrum_peak
    ADD CONSTRAINT spectrum_peak_pkey PRIMARY KEY (id);


--
-- Name: spectrum_pkey; Type: CONSTRAINT; Schema: public; Owner: myXi3_user; Tablespace:
--

ALTER TABLE ONLY spectrum
    ADD CONSTRAINT spectrum_pkey PRIMARY KEY (id);


--
-- Name: storage_ids_pkey; Type: CONSTRAINT; Schema: public; Owner: myXi3_user; Tablespace:
--

ALTER TABLE ONLY storage_ids
    ADD CONSTRAINT storage_ids_pkey PRIMARY KEY (name);


--
-- Name: user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: myXi3_user; Tablespace:
--

ALTER TABLE ONLY user_groups
    ADD CONSTRAINT user_groups_pkey PRIMARY KEY (id);


--
-- Name: user_in_group_pkey; Type: CONSTRAINT; Schema: public; Owner: myXi3_user; Tablespace:
--

ALTER TABLE ONLY user_in_group
    ADD CONSTRAINT user_in_group_pkey PRIMARY KEY (user_id, group_id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: myXi3_user; Tablespace:
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users_user_name_key; Type: CONSTRAINT; Schema: public; Owner: myXi3_user; Tablespace:
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_user_name_key UNIQUE (user_name);


--
-- Name: isdecoy_searchid_idx; Type: INDEX; Schema: public; Owner: myXi3_user; Tablespace:
--

CREATE INDEX isdecoy_searchid_idx ON spectrum_match USING btree (is_decoy, search_id);


--
-- Name: matched_peptide_link_position; Type: INDEX; Schema: public; Owner: myXi3_user; Tablespace:
--

CREATE INDEX matched_peptide_link_position ON matched_peptide USING btree (link_position);


--
-- Name: matched_peptide_match_id_btree; Type: INDEX; Schema: public; Owner: myXi3_user; Tablespace:
--

CREATE INDEX matched_peptide_match_id_btree ON matched_peptide USING btree (match_id);


--
-- Name: matched_peptide_search_idx; Type: INDEX; Schema: public; Owner: myXi3_user; Tablespace:
--

CREATE INDEX matched_peptide_search_idx ON matched_peptide USING btree (search_id);


--
-- Name: protein_accession_number_idx; Type: INDEX; Schema: public; Owner: myXi3_user; Tablespace:
--

CREATE INDEX protein_accession_number_idx ON protein USING btree (accession_number);


--
-- Name: spectrum_match_dynamic_rank_search_id_idx; Type: INDEX; Schema: public; Owner: myXi3_user; Tablespace:
--

CREATE INDEX spectrum_match_dynamic_rank_search_id_idx ON spectrum_match USING btree (dynamic_rank, search_id);


--
-- Name: spectrum_match_rescored_idx; Type: INDEX; Schema: public; Owner: myXi3_user; Tablespace:
--

CREATE INDEX spectrum_match_rescored_idx ON spectrum_match USING btree (rescored);


--
-- Name: spectrum_match_search_id_idx; Type: INDEX; Schema: public; Owner: myXi3_user; Tablespace:
--

CREATE INDEX spectrum_match_search_id_idx ON spectrum_match USING btree (search_id);


--
-- Name: spectrum_match_spectrum_id; Type: INDEX; Schema: public; Owner: myXi3_user; Tablespace:
--

CREATE INDEX spectrum_match_spectrum_id ON spectrum_match USING btree (spectrum_id);


--
-- Name: spectrum_peak_spectrum_idx; Type: INDEX; Schema: public; Owner: myXi3_user; Tablespace:
--

CREATE INDEX spectrum_peak_spectrum_idx ON spectrum_peak USING btree (spectrum_id);


--
-- Name: version_index_component; Type: INDEX; Schema: public; Owner: myXi3_user; Tablespace:
--

CREATE INDEX version_index_component ON version_number USING btree (component, current);


--
-- Name: acquisition_uploadedby_fkey; Type: FK CONSTRAINT; Schema: public; Owner: myXi3_user
--

ALTER TABLE ONLY acquisition
    ADD CONSTRAINT acquisition_uploadedby_fkey FOREIGN KEY (uploadedby) REFERENCES users(id);


--
-- Name: chosen_crosslinker_crosslinker_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: myXi3_user
--

ALTER TABLE ONLY chosen_crosslinker
    ADD CONSTRAINT chosen_crosslinker_crosslinker_id_fkey FOREIGN KEY (crosslinker_id) REFERENCES crosslinker(id);


--
-- Name: chosen_crosslinker_paramset_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: myXi3_user
--

ALTER TABLE ONLY chosen_crosslinker
    ADD CONSTRAINT chosen_crosslinker_paramset_id_fkey FOREIGN KEY (paramset_id) REFERENCES parameter_set(id) ON DELETE CASCADE;


--
-- Name: chosen_ions_ion_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: myXi3_user
--

ALTER TABLE ONLY chosen_ions
    ADD CONSTRAINT chosen_ions_ion_id_fkey FOREIGN KEY (ion_id) REFERENCES ion(id);


--
-- Name: chosen_ions_paramset_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: myXi3_user
--

ALTER TABLE ONLY chosen_ions
    ADD CONSTRAINT chosen_ions_paramset_id_fkey FOREIGN KEY (paramset_id) REFERENCES parameter_set(id) ON DELETE CASCADE;


--
-- Name: chosen_label_scheme_label_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: myXi3_user
--

ALTER TABLE ONLY chosen_label_scheme
    ADD CONSTRAINT chosen_label_scheme_label_id_fkey FOREIGN KEY (label_id) REFERENCES label(id);


--
-- Name: chosen_label_scheme_paramset_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: myXi3_user
--

ALTER TABLE ONLY chosen_label_scheme
    ADD CONSTRAINT chosen_label_scheme_paramset_id_fkey FOREIGN KEY (paramset_id) REFERENCES parameter_set(id) ON DELETE CASCADE;


--
-- Name: chosen_label_scheme_scheme_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: myXi3_user
--

ALTER TABLE ONLY chosen_label_scheme
    ADD CONSTRAINT chosen_label_scheme_scheme_id_fkey FOREIGN KEY (scheme_id) REFERENCES label_scheme(id);


--
-- Name: chosen_losses_loss_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: myXi3_user
--

ALTER TABLE ONLY chosen_losses
    ADD CONSTRAINT chosen_losses_loss_id_fkey FOREIGN KEY (loss_id) REFERENCES loss(id);


--
-- Name: chosen_losses_paramset_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: myXi3_user
--

ALTER TABLE ONLY chosen_losses
    ADD CONSTRAINT chosen_losses_paramset_id_fkey FOREIGN KEY (paramset_id) REFERENCES parameter_set(id) ON DELETE CASCADE;


--
-- Name: chosen_modification_mod_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: myXi3_user
--

ALTER TABLE ONLY chosen_modification
    ADD CONSTRAINT chosen_modification_mod_id_fkey FOREIGN KEY (mod_id) REFERENCES modification(id);


--
-- Name: chosen_modification_paramset_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: myXi3_user
--

ALTER TABLE ONLY chosen_modification
    ADD CONSTRAINT chosen_modification_paramset_id_fkey FOREIGN KEY (paramset_id) REFERENCES parameter_set(id) ON DELETE CASCADE;


--
-- Name: fk_spectrum_spectrum_source; Type: FK CONSTRAINT; Schema: public; Owner: myXi3_user
--

ALTER TABLE ONLY spectrum
    ADD CONSTRAINT fk_spectrum_spectrum_source FOREIGN KEY (source_id) REFERENCES spectrum_source(id);


--
-- Name: has_protein_peptide_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: myXi3_user
--

ALTER TABLE ONLY has_protein
    ADD CONSTRAINT has_protein_peptide_id_fkey FOREIGN KEY (peptide_id) REFERENCES peptide(id) ON DELETE CASCADE;


--
-- Name: has_protein_protein_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: myXi3_user
--

ALTER TABLE ONLY has_protein
    ADD CONSTRAINT has_protein_protein_id_fkey FOREIGN KEY (protein_id) REFERENCES protein(id) ON DELETE CASCADE;


--
-- Name: matched_peptide_crosslinker_fk; Type: FK CONSTRAINT; Schema: public; Owner: myXi3_user
--

ALTER TABLE ONLY matched_peptide
    ADD CONSTRAINT matched_peptide_crosslinker_fk FOREIGN KEY (crosslinker_id) REFERENCES crosslinker(id);


--
-- Name: matched_peptide_match_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: myXi3_user
--

ALTER TABLE ONLY matched_peptide
    ADD CONSTRAINT matched_peptide_match_id_fkey FOREIGN KEY (match_id) REFERENCES spectrum_match(id) ON DELETE CASCADE;


--
-- Name: matched_peptide_match_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: myXi3_user
--

ALTER TABLE ONLY matched_peptide
    ADD CONSTRAINT matched_peptide_match_type_fkey FOREIGN KEY (match_type) REFERENCES match_type(id);


--
-- Name: matched_peptide_peptide_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: myXi3_user
--

ALTER TABLE ONLY matched_peptide
    ADD CONSTRAINT matched_peptide_peptide_id_fkey FOREIGN KEY (peptide_id) REFERENCES peptide(id) ON DELETE CASCADE;


--
-- Name: parameter_set_enzyme_chosen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: myXi3_user
--

ALTER TABLE ONLY parameter_set
    ADD CONSTRAINT parameter_set_enzyme_chosen_fkey FOREIGN KEY (enzyme_chosen) REFERENCES enzyme(id);


--
-- Name: run_acq_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: myXi3_user
--

ALTER TABLE ONLY run
    ADD CONSTRAINT run_acq_id_fkey FOREIGN KEY (acq_id) REFERENCES acquisition(id) ON DELETE CASCADE;


--
-- Name: search_acquisition_acq_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: myXi3_user
--

ALTER TABLE ONLY search_acquisition
    ADD CONSTRAINT search_acquisition_acq_id_fkey FOREIGN KEY (acq_id, run_id) REFERENCES run(acq_id, run_id) ON DELETE CASCADE;


--
-- Name: search_acquisition_search_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: myXi3_user
--

ALTER TABLE ONLY search_acquisition
    ADD CONSTRAINT search_acquisition_search_id_fkey FOREIGN KEY (search_id) REFERENCES search(id) ON DELETE CASCADE;


--
-- Name: search_paramset_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: myXi3_user
--

ALTER TABLE ONLY search
    ADD CONSTRAINT search_paramset_id_fkey FOREIGN KEY (paramset_id) REFERENCES parameter_set(id);


--
-- Name: search_sequencedb_search_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: myXi3_user
--

ALTER TABLE ONLY search_sequencedb
    ADD CONSTRAINT search_sequencedb_search_id_fkey FOREIGN KEY (search_id) REFERENCES search(id) ON DELETE CASCADE;


--
-- Name: search_sequencedb_seqdb_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: myXi3_user
--

ALTER TABLE ONLY search_sequencedb
    ADD CONSTRAINT search_sequencedb_seqdb_id_fkey FOREIGN KEY (seqdb_id) REFERENCES sequence_file(id) ON DELETE CASCADE;


--
-- Name: search_uploadedby_fkey; Type: FK CONSTRAINT; Schema: public; Owner: myXi3_user
--

ALTER TABLE ONLY search
    ADD CONSTRAINT search_uploadedby_fkey FOREIGN KEY (uploadedby) REFERENCES users(id);


--
-- Name: search_visible_group_fkey; Type: FK CONSTRAINT; Schema: public; Owner: myXi3_user
--

ALTER TABLE ONLY search
    ADD CONSTRAINT search_visible_group_fkey FOREIGN KEY (visible_group) REFERENCES user_groups(id);


--
-- Name: sequence_file_uploadedby_fkey; Type: FK CONSTRAINT; Schema: public; Owner: myXi3_user
--

ALTER TABLE ONLY sequence_file
    ADD CONSTRAINT sequence_file_uploadedby_fkey FOREIGN KEY (uploadedby) REFERENCES users(id);


--
-- Name: spectrum_acq_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: myXi3_user
--

ALTER TABLE ONLY spectrum
    ADD CONSTRAINT spectrum_acq_id_fkey FOREIGN KEY (acq_id, run_id) REFERENCES run(acq_id, run_id) ON DELETE CASCADE;


--
-- Name: spectrum_match_search_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: myXi3_user
--

ALTER TABLE ONLY spectrum_match
    ADD CONSTRAINT spectrum_match_search_id_fkey FOREIGN KEY (search_id) REFERENCES search(id) ON DELETE CASCADE;


--
-- Name: spectrum_match_spectrum_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: myXi3_user
--

ALTER TABLE ONLY spectrum_match
    ADD CONSTRAINT spectrum_match_spectrum_id_fkey FOREIGN KEY (spectrum_id) REFERENCES spectrum(id) ON DELETE CASCADE;


--
-- Name: spectrum_peak_spectrum_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: myXi3_user
--

ALTER TABLE ONLY spectrum_peak
    ADD CONSTRAINT spectrum_peak_spectrum_id_fkey FOREIGN KEY (spectrum_id) REFERENCES spectrum(id) ON DELETE CASCADE;


--
-- Name: user_in_group_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: myXi3_user
--

ALTER TABLE ONLY user_in_group
    ADD CONSTRAINT user_in_group_group_id_fkey FOREIGN KEY (group_id) REFERENCES user_groups(id);


--
-- Name: user_in_group_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: myXi3_user
--

ALTER TABLE ONLY user_in_group
    ADD CONSTRAINT user_in_group_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

