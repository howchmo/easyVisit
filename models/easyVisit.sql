--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.2
-- Dumped by pg_dump version 9.5.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: badges; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE badges (
    badge character varying(64) NOT NULL
);


ALTER TABLE badges OWNER TO postgres;

--
-- Name: visitees; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE visitees (
    visitee integer NOT NULL,
    name text NOT NULL,
    imgurl text,
    frontpage boolean
);


ALTER TABLE visitees OWNER TO postgres;

--
-- Name: visitees_visitee_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE visitees_visitee_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE visitees_visitee_seq OWNER TO postgres;

--
-- Name: visitees_visitee_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE visitees_visitee_seq OWNED BY visitees.visitee;


--
-- Name: visitors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE visitors (
    visitor integer NOT NULL,
    name text NOT NULL,
    organization text NOT NULL,
    citizenship text NOT NULL
);


ALTER TABLE visitors OWNER TO postgres;

--
-- Name: visitors_visitor_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE visitors_visitor_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE visitors_visitor_seq OWNER TO postgres;

--
-- Name: visitors_visitor_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE visitors_visitor_seq OWNED BY visitors.visitor;


--
-- Name: visits; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE visits (
    visit integer NOT NULL,
    visitee integer NOT NULL,
    visitor integer NOT NULL,
    purpose text NOT NULL,
    arrival timestamp with time zone DEFAULT now(),
    departure timestamp with time zone,
    badge text NOT NULL
);


ALTER TABLE visits OWNER TO postgres;

--
-- Name: visits_visit_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE visits_visit_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE visits_visit_seq OWNER TO postgres;

--
-- Name: visits_visit_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE visits_visit_seq OWNED BY visits.visit;


--
-- Name: visitee; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY visitees ALTER COLUMN visitee SET DEFAULT nextval('visitees_visitee_seq'::regclass);


--
-- Name: visitor; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY visitors ALTER COLUMN visitor SET DEFAULT nextval('visitors_visitor_seq'::regclass);


--
-- Name: visit; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY visits ALTER COLUMN visit SET DEFAULT nextval('visits_visit_seq'::regclass);


--
-- Data for Name: badges; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY badges (badge) FROM stdin;
ecs-visitor-894673206762
\.


--
-- Data for Name: visitees; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY visitees (visitee, name, imgurl, frontpage) FROM stdin;
1	Archie	img/Archie.jpg	t
2	Buzz Lightyear	img/BuzzLightyear.jpg	t
3	CAPT Crunch	img/CapnCrunch-REV.jpg	t
4	Elmer Fudd	img/ElmerFudd.jpg	t
5	Fozzie Bear	img/FozzieBear.jpg	t
6	Fat Albert	img/FatAlbert.jpg	t
7	Wile E. Coyote	img/WileECoyote.jpg	t
8	Shaggy	img/Shaggy.jpg	t
\.


--
-- Name: visitees_visitee_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('visitees_visitee_seq', 0, true);

--
-- Name: visitors_visitor_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('visitors_visitor_seq', 0, true);

--
-- Name: visits_visit_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('visits_visit_seq', 0, true);


--
-- Name: badges_badge_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY badges
    ADD CONSTRAINT badges_badge_key UNIQUE (badge);


--
-- Name: badges_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY badges
    ADD CONSTRAINT badges_pkey PRIMARY KEY (badge);


--
-- Name: visitees_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY visitees
    ADD CONSTRAINT visitees_pkey PRIMARY KEY (visitee);


--
-- Name: visitors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY visitors
    ADD CONSTRAINT visitors_pkey PRIMARY KEY (visitor);


--
-- Name: visits_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY visits
    ADD CONSTRAINT visits_pkey PRIMARY KEY (visit);


--
-- Name: visits_badge_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY visits
    ADD CONSTRAINT visits_badge_fkey FOREIGN KEY (badge) REFERENCES badges(badge);


--
-- Name: visits_visitee_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY visits
    ADD CONSTRAINT visits_visitee_fkey FOREIGN KEY (visitee) REFERENCES visitees(visitee);


--
-- Name: visits_visitor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY visits
    ADD CONSTRAINT visits_visitor_fkey FOREIGN KEY (visitor) REFERENCES visitors(visitor);


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

