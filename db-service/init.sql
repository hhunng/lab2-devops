--
-- PostgreSQL database dump
--

-- Dumped from database version 13.4
-- Dumped by pg_dump version 13.4
---------------------------
SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;
--------
--
-- Name: admin; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin (
    id integer NOT NULL,
    firstname character varying(45) NOT NULL,
    lastname character varying(45) NOT NULL,
    age integer NOT NULL,
    date_started date NOT NULL,
    status integer NOT NULL,
    login_id integer NOT NULL,
    birthday date NOT NULL
);


ALTER TABLE public.admin OWNER TO postgres;

--
-- Name: billing; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.billing (
    id integer NOT NULL,
    payable double precision NOT NULL,
    approved_by character varying(45) NOT NULL,
    date_approved date NOT NULL,
    date_billed date NOT NULL,
    total_issues integer NOT NULL,
    vendor_id integer NOT NULL,
    admin_id integer NOT NULL,
    received_by character varying(45) NOT NULL,
    date_received date NOT NULL
);


ALTER TABLE public.billing OWNER TO postgres;

--
-- Name: content; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.content (
    id integer NOT NULL,
    publication_id integer NOT NULL,
    headline character varying(100) NOT NULL,
    content text NOT NULL,
    content_type character varying(20) NOT NULL,
    date_published date NOT NULL
);


ALTER TABLE public.content OWNER TO postgres;

--
-- Name: customer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer (
    id integer NOT NULL,
    firstname character varying(45) NOT NULL,
    lastname character varying(45) NOT NULL,
    age integer NOT NULL,
    birthday date NOT NULL,
    date_subscribed date NOT NULL,
    status integer NOT NULL,
    subscription_type integer NOT NULL,
    login_id integer NOT NULL
);


ALTER TABLE public.customer OWNER TO postgres;

--
-- Name: login; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.login (
    id integer NOT NULL,
    username character varying(45) NOT NULL,
    password character varying(45) NOT NULL,
    user_type integer NOT NULL
);


ALTER TABLE public.login OWNER TO postgres;

--
-- Name: messenger; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.messenger (
    id integer NOT NULL,
    firstname character varying(45) NOT NULL,
    lastname character varying(45) NOT NULL,
    salary double precision NOT NULL,
    date_employed date NOT NULL,
    status integer NOT NULL,
    vendor_id integer NOT NULL
);


ALTER TABLE public.messenger OWNER TO postgres;

--
-- Name: publication; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.publication (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    type character varying(45) NOT NULL,
    vendor_id integer NOT NULL,
    messenger_id integer NOT NULL
);


ALTER TABLE public.publication OWNER TO postgres;

--
-- Name: sales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sales (
    id integer NOT NULL,
    publication_id integer NOT NULL,
    copies_issued integer NOT NULL,
    date_issued date NOT NULL,
    revenue double precision NOT NULL,
    profit double precision NOT NULL,
    copies_sold integer NOT NULL
);


ALTER TABLE public.sales OWNER TO postgres;

--
-- Name: subscription; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subscription (
    id integer NOT NULL,
    customer_id integer NOT NULL,
    branch character varying(100) NOT NULL,
    price double precision NOT NULL,
    qty integer NOT NULL,
    date_purchased date NOT NULL
);


ALTER TABLE public.subscription OWNER TO postgres;

--
-- Name: vendor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vendor (
    id integer NOT NULL,
    rep_firstname character varying(45) NOT NULL,
    rep_lastname character varying(45) NOT NULL,
    rep_id character varying(45) NOT NULL,
    rep_date_employed date NOT NULL,
    account_name character varying(45) NOT NULL,
    account_number character varying(45) NOT NULL,
    date_consigned date NOT NULL,
    login_id integer NOT NULL
);


ALTER TABLE public.vendor OWNER TO postgres;

------


--
-- Name: admin admin_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_pkey PRIMARY KEY (id);


--
-- Name: billing billing_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.billing
    ADD CONSTRAINT billing_pkey PRIMARY KEY (id);


--
-- Name: content content_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content
    ADD CONSTRAINT content_pkey PRIMARY KEY (id);


--
-- Name: customer customer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (id);


--
-- Name: login login_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.login
    ADD CONSTRAINT login_pkey PRIMARY KEY (id);


--
-- Name: login login_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.login
    ADD CONSTRAINT login_username_key UNIQUE (username);


--
-- Name: messenger messenger_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messenger
    ADD CONSTRAINT messenger_pkey PRIMARY KEY (id);


--
-- Name: publication publication_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publication
    ADD CONSTRAINT publication_pkey PRIMARY KEY (id);


--
-- Name: subscription subscription_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscription
    ADD CONSTRAINT subscription_pkey PRIMARY KEY (id);


--
-- Name: vendor vendor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendor
    ADD CONSTRAINT vendor_pkey PRIMARY KEY (id);


--
-- Name: admin fk_admin_login; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT fk_admin_login FOREIGN KEY (login_id) REFERENCES public.login(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: billing fk_billing_admin1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.billing
    ADD CONSTRAINT fk_billing_admin1 FOREIGN KEY (admin_id) REFERENCES public.admin(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: billing fk_billing_vendor1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.billing
    ADD CONSTRAINT fk_billing_vendor1 FOREIGN KEY (vendor_id) REFERENCES public.vendor(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: content fk_content_publication1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content
    ADD CONSTRAINT fk_content_publication1 FOREIGN KEY (publication_id) REFERENCES public.publication(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: customer fk_customer_login1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT fk_customer_login1 FOREIGN KEY (login_id) REFERENCES public.login(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: sales fk_issues_publication1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT fk_issues_publication1 FOREIGN KEY (publication_id) REFERENCES public.publication(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: messenger fk_messenger_vendor1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messenger
    ADD CONSTRAINT fk_messenger_vendor1 FOREIGN KEY (vendor_id) REFERENCES public.vendor(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: publication fk_publication_messenger1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publication
    ADD CONSTRAINT fk_publication_messenger1 FOREIGN KEY (messenger_id) REFERENCES public.messenger(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: publication fk_publication_vendor1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publication
    ADD CONSTRAINT fk_publication_vendor1 FOREIGN KEY (vendor_id) REFERENCES public.vendor(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: subscription fk_subscription_customer1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscription
    ADD CONSTRAINT fk_subscription_customer1 FOREIGN KEY (customer_id) REFERENCES public.customer(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: vendor fk_vendor_login1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendor
    ADD CONSTRAINT fk_vendor_login1 FOREIGN KEY (login_id) REFERENCES public.login(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--



