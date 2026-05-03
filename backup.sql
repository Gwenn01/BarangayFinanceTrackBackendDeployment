--
-- PostgreSQL database dump
--

\restrict iD4m0SfR7uE1sj5QfS2omKVvcOecO7iSQi40lJVGPwYq4i5fL2HPufdcmgBpklL

-- Dumped from database version 18.3 (Debian 18.3-1.pgdg12+1)
-- Dumped by pg_dump version 18.3 (Debian 18.3-1.pgdg13+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: barangayfinancetrackdb_user
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO barangayfinancetrackdb_user;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: activity_logs; Type: TABLE; Schema: public; Owner: barangayfinancetrackdb_user
--

CREATE TABLE public.activity_logs (
    id integer NOT NULL,
    user_id integer,
    username character varying(150),
    action character varying(50) NOT NULL,
    module character varying(100),
    description text,
    ip_address text,
    user_agent text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.activity_logs OWNER TO barangayfinancetrackdb_user;

--
-- Name: activity_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: barangayfinancetrackdb_user
--

CREATE SEQUENCE public.activity_logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.activity_logs_id_seq OWNER TO barangayfinancetrackdb_user;

--
-- Name: activity_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: barangayfinancetrackdb_user
--

ALTER SEQUENCE public.activity_logs_id_seq OWNED BY public.activity_logs.id;


--
-- Name: budget_allocations; Type: TABLE; Schema: public; Owner: barangayfinancetrackdb_user
--

CREATE TABLE public.budget_allocations (
    id integer NOT NULL,
    category character varying(100) NOT NULL,
    allocated_amount numeric(14,2) NOT NULL,
    utilized_amount numeric(14,2) DEFAULT 0.00,
    year integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.budget_allocations OWNER TO barangayfinancetrackdb_user;

--
-- Name: budget_allocations_id_seq; Type: SEQUENCE; Schema: public; Owner: barangayfinancetrackdb_user
--

CREATE SEQUENCE public.budget_allocations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.budget_allocations_id_seq OWNER TO barangayfinancetrackdb_user;

--
-- Name: budget_allocations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: barangayfinancetrackdb_user
--

ALTER SEQUENCE public.budget_allocations_id_seq OWNED BY public.budget_allocations.id;


--
-- Name: budget_entries; Type: TABLE; Schema: public; Owner: barangayfinancetrackdb_user
--

CREATE TABLE public.budget_entries (
    id integer NOT NULL,
    transaction_id character varying(50) NOT NULL,
    transaction_date date NOT NULL,
    category character varying(100),
    subcategory character varying(100),
    amount numeric(12,2) NOT NULL,
    fund_source character varying(100),
    payee character varying(150),
    dv_number character varying(50),
    expenditure_program character varying(150),
    program_description text,
    remarks text,
    allocation_id integer,
    created_by integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    file_path text,
    program character varying(100)
);


ALTER TABLE public.budget_entries OWNER TO barangayfinancetrackdb_user;

--
-- Name: budget_entries_id_seq; Type: SEQUENCE; Schema: public; Owner: barangayfinancetrackdb_user
--

CREATE SEQUENCE public.budget_entries_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.budget_entries_id_seq OWNER TO barangayfinancetrackdb_user;

--
-- Name: budget_entries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: barangayfinancetrackdb_user
--

ALTER SEQUENCE public.budget_entries_id_seq OWNED BY public.budget_entries.id;


--
-- Name: collections; Type: TABLE; Schema: public; Owner: barangayfinancetrackdb_user
--

CREATE TABLE public.collections (
    id integer NOT NULL,
    transaction_id character varying(50) NOT NULL,
    transaction_date date NOT NULL,
    category character varying(100),
    amount numeric(12,2) NOT NULL,
    payor character varying(150),
    nature_of_collection character varying(150),
    description text,
    fund_source character varying(150),
    or_number character varying(100),
    remarks text,
    review_status character varying(20) DEFAULT 'pending'::character varying,
    is_flagged boolean DEFAULT false,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    created_by integer NOT NULL,
    file_path text,
    CONSTRAINT collections_review_status_check CHECK (((review_status)::text = ANY ((ARRAY['pending'::character varying, 'approved'::character varying, 'rejected'::character varying])::text[])))
);


ALTER TABLE public.collections OWNER TO barangayfinancetrackdb_user;

--
-- Name: collections_id_seq; Type: SEQUENCE; Schema: public; Owner: barangayfinancetrackdb_user
--

CREATE SEQUENCE public.collections_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.collections_id_seq OWNER TO barangayfinancetrackdb_user;

--
-- Name: collections_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: barangayfinancetrackdb_user
--

ALTER SEQUENCE public.collections_id_seq OWNED BY public.collections.id;


--
-- Name: dfur_projects; Type: TABLE; Schema: public; Owner: barangayfinancetrackdb_user
--

CREATE TABLE public.dfur_projects (
    id integer NOT NULL,
    transaction_id character varying(50) NOT NULL,
    transaction_date date NOT NULL,
    name_of_collection character varying(100),
    project character varying(200),
    location character varying(150),
    total_cost_approved numeric(14,2) NOT NULL,
    total_cost_incurred numeric(14,2),
    date_started date,
    target_completion_date date,
    status character varying(20) DEFAULT 'planned'::character varying,
    no_extensions integer,
    remarks character varying(200),
    review_status character varying(20) DEFAULT 'pending'::character varying,
    is_flagged boolean DEFAULT false,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    file_path text,
    CONSTRAINT dfur_projects_review_status_check CHECK (((review_status)::text = ANY ((ARRAY['pending'::character varying, 'approved'::character varying, 'rejected'::character varying, 'completed'::character varying])::text[]))),
    CONSTRAINT dfur_projects_status_check CHECK (((status)::text = ANY ((ARRAY['planned'::character varying, 'in_progress'::character varying, 'completed'::character varying, 'on_hold'::character varying, 'cancelled'::character varying])::text[])))
);


ALTER TABLE public.dfur_projects OWNER TO barangayfinancetrackdb_user;

--
-- Name: dfur_projects_id_seq; Type: SEQUENCE; Schema: public; Owner: barangayfinancetrackdb_user
--

CREATE SEQUENCE public.dfur_projects_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dfur_projects_id_seq OWNER TO barangayfinancetrackdb_user;

--
-- Name: dfur_projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: barangayfinancetrackdb_user
--

ALTER SEQUENCE public.dfur_projects_id_seq OWNED BY public.dfur_projects.id;


--
-- Name: disbursements; Type: TABLE; Schema: public; Owner: barangayfinancetrackdb_user
--

CREATE TABLE public.disbursements (
    id integer NOT NULL,
    transaction_id character varying(50) NOT NULL,
    transaction_date date NOT NULL,
    category character varying(100),
    subcategory character varying(100),
    amount numeric(12,2) NOT NULL,
    payee character varying(150),
    nature_of_disbursement character varying(150),
    description text,
    fund_source character varying(150),
    or_number character varying(100),
    remarks text,
    review_status character varying(20) DEFAULT 'pending'::character varying,
    is_flagged boolean DEFAULT false,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    created_by integer NOT NULL,
    allocation_id integer,
    file_path text,
    supporting_doc character varying(255),
    CONSTRAINT disbursements_review_status_check CHECK (((review_status)::text = ANY ((ARRAY['pending'::character varying, 'approved'::character varying, 'rejected'::character varying])::text[])))
);


ALTER TABLE public.disbursements OWNER TO barangayfinancetrackdb_user;

--
-- Name: disbursements_id_seq; Type: SEQUENCE; Schema: public; Owner: barangayfinancetrackdb_user
--

CREATE SEQUENCE public.disbursements_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.disbursements_id_seq OWNER TO barangayfinancetrackdb_user;

--
-- Name: disbursements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: barangayfinancetrackdb_user
--

ALTER SEQUENCE public.disbursements_id_seq OWNED BY public.disbursements.id;


--
-- Name: flag_comments; Type: TABLE; Schema: public; Owner: barangayfinancetrackdb_user
--

CREATE TABLE public.flag_comments (
    id integer NOT NULL,
    comment_text text NOT NULL,
    flagged_by integer,
    collection_id integer,
    disbursement_id integer,
    dfur_project_id integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    username character varying(255),
    CONSTRAINT only_one_reference CHECK ((((((collection_id IS NOT NULL))::integer + ((disbursement_id IS NOT NULL))::integer) + ((dfur_project_id IS NOT NULL))::integer) = 1))
);


ALTER TABLE public.flag_comments OWNER TO barangayfinancetrackdb_user;

--
-- Name: flag_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: barangayfinancetrackdb_user
--

CREATE SEQUENCE public.flag_comments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.flag_comments_id_seq OWNER TO barangayfinancetrackdb_user;

--
-- Name: flag_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: barangayfinancetrackdb_user
--

ALTER SEQUENCE public.flag_comments_id_seq OWNED BY public.flag_comments.id;


--
-- Name: tables; Type: TABLE; Schema: public; Owner: barangayfinancetrackdb_user
--

CREATE TABLE public.tables (
    table_name information_schema.sql_identifier
);


ALTER TABLE public.tables OWNER TO barangayfinancetrackdb_user;

--
-- Name: users; Type: TABLE; Schema: public; Owner: barangayfinancetrackdb_user
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(100) NOT NULL,
    password character varying(255) NOT NULL,
    role character varying(20) NOT NULL,
    full_name character varying(150) NOT NULL,
    "position" character varying(100),
    is_active boolean DEFAULT true,
    last_login timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT users_role_check CHECK (((role)::text = ANY ((ARRAY['superadmin'::character varying, 'admin'::character varying, 'encoder'::character varying, 'checker'::character varying, 'reviewer'::character varying, 'approver'::character varying])::text[])))
);


ALTER TABLE public.users OWNER TO barangayfinancetrackdb_user;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: barangayfinancetrackdb_user
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO barangayfinancetrackdb_user;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: barangayfinancetrackdb_user
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: viewer_comments; Type: TABLE; Schema: public; Owner: barangayfinancetrackdb_user
--

CREATE TABLE public.viewer_comments (
    id integer NOT NULL,
    comment text NOT NULL,
    name character varying(255),
    email character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.viewer_comments OWNER TO barangayfinancetrackdb_user;

--
-- Name: viewer_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: barangayfinancetrackdb_user
--

CREATE SEQUENCE public.viewer_comments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.viewer_comments_id_seq OWNER TO barangayfinancetrackdb_user;

--
-- Name: viewer_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: barangayfinancetrackdb_user
--

ALTER SEQUENCE public.viewer_comments_id_seq OWNED BY public.viewer_comments.id;


--
-- Name: activity_logs id; Type: DEFAULT; Schema: public; Owner: barangayfinancetrackdb_user
--

ALTER TABLE ONLY public.activity_logs ALTER COLUMN id SET DEFAULT nextval('public.activity_logs_id_seq'::regclass);


--
-- Name: budget_allocations id; Type: DEFAULT; Schema: public; Owner: barangayfinancetrackdb_user
--

ALTER TABLE ONLY public.budget_allocations ALTER COLUMN id SET DEFAULT nextval('public.budget_allocations_id_seq'::regclass);


--
-- Name: budget_entries id; Type: DEFAULT; Schema: public; Owner: barangayfinancetrackdb_user
--

ALTER TABLE ONLY public.budget_entries ALTER COLUMN id SET DEFAULT nextval('public.budget_entries_id_seq'::regclass);


--
-- Name: collections id; Type: DEFAULT; Schema: public; Owner: barangayfinancetrackdb_user
--

ALTER TABLE ONLY public.collections ALTER COLUMN id SET DEFAULT nextval('public.collections_id_seq'::regclass);


--
-- Name: dfur_projects id; Type: DEFAULT; Schema: public; Owner: barangayfinancetrackdb_user
--

ALTER TABLE ONLY public.dfur_projects ALTER COLUMN id SET DEFAULT nextval('public.dfur_projects_id_seq'::regclass);


--
-- Name: disbursements id; Type: DEFAULT; Schema: public; Owner: barangayfinancetrackdb_user
--

ALTER TABLE ONLY public.disbursements ALTER COLUMN id SET DEFAULT nextval('public.disbursements_id_seq'::regclass);


--
-- Name: flag_comments id; Type: DEFAULT; Schema: public; Owner: barangayfinancetrackdb_user
--

ALTER TABLE ONLY public.flag_comments ALTER COLUMN id SET DEFAULT nextval('public.flag_comments_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: barangayfinancetrackdb_user
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: viewer_comments id; Type: DEFAULT; Schema: public; Owner: barangayfinancetrackdb_user
--

ALTER TABLE ONLY public.viewer_comments ALTER COLUMN id SET DEFAULT nextval('public.viewer_comments_id_seq'::regclass);


--
-- Data for Name: activity_logs; Type: TABLE DATA; Schema: public; Owner: barangayfinancetrackdb_user
--

COPY public.activity_logs (id, user_id, username, action, module, description, ip_address, user_agent, created_at) FROM stdin;
74	4	treasurer	logout	authentication	treasurer logged out	127.0.0.1	PostmanRuntime/7.52.0	2026-03-08 12:17:19.487148
77	4	treasurer	login	authentication	treasurer logged in	10.17.12.130	PostmanRuntime/7.52.0	2026-03-08 13:28:20.696184
80	4	treasurer	login	authentication	treasurer logged in	10.23.4.2	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-08 15:05:28.998696
83	3	secretary	login	authentication	secretary logged in	10.18.165.136	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-08 15:26:54.399871
86	4	treasurer	login	authentication	treasurer logged in	10.23.4.2	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-08 15:58:42.381592
89	1	superadmin	login	authentication	superadmin logged in	10.23.202.200	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-08 16:05:49.494506
92	1	superadmin	logout	authentication	superadmin logged out	10.18.165.136	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-08 16:10:05.903852
95	4	treasurer	login	authentication	treasurer logged in	10.23.202.200	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-08 16:10:34.680342
98	7	approver	logout	authentication	approver logged out	10.18.165.136	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-08 16:11:05.775555
101	3	secretary	login	authentication	secretary logged in	10.17.174.195	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-08 16:11:27.044955
104	6	council1	login	authentication	council1 logged in	10.19.233.134	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-08 16:15:15.96054
107	3	secretary	logout	authentication	secretary logged out	10.23.202.200	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-09 15:19:22.590828
110	4	treasurer	login	authentication	treasurer logged in	10.23.202.200	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 05:39:45.909513
113	4	treasurer	logout	authentication	treasurer logged out	10.19.233.134	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 06:06:36.195694
116	4	treasurer	login	authentication	treasurer logged in	10.18.165.136	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 09:09:39.577084
119	5	bookkeeper	logout	authentication	bookkeeper logged out	10.18.165.136	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 12:40:50.887754
122	4	treasurer	logout	authentication	treasurer logged out	10.18.165.136	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 12:42:32.599782
125	4	treasurer	logout	authentication	treasurer logged out	10.18.165.136	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	2026-03-10 15:56:21.857554
128	7	approver	login	authentication	approver logged in	10.17.12.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 16:05:39.737158
131	4	treasurer	logout	authentication	treasurer logged out	10.23.4.2	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 16:14:54.37243
134	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.23.4.2	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 16:34:46.679439
137	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.18.165.136	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 16:34:47.34615
140	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.23.4.2	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 16:34:47.998872
143	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.23.4.2	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 16:34:48.892995
146	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.18.165.136	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 16:34:49.535973
149	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.23.202.200	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 16:34:50.257426
152	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.23.4.2	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 16:34:50.906785
155	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.17.174.195	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 16:39:42.057833
158	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.19.233.134	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 16:39:42.717958
161	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.23.202.200	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 16:39:43.392437
163	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.17.12.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 16:39:43.835197
78	4	treasurer	login	authentication	treasurer logged in	10.17.12.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-08 13:57:04.17297
81	5	bookkeeper	login	authentication	bookkeeper logged in	10.17.12.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-08 15:05:49.582909
84	6	council1	login	authentication	council1 logged in	10.23.202.200	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-08 15:28:31.045423
87	1	superadmin	login	authentication	superadmin logged in	10.17.174.195	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-08 15:58:54.145054
90	1	superadmin	login	authentication	superadmin logged in	10.23.4.2	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-08 16:07:28.29622
93	1	superadmin	login	authentication	superadmin logged in	10.23.4.2	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-08 16:10:15.575322
96	4	treasurer	logout	authentication	treasurer logged out	10.17.12.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-08 16:10:51.609134
99	5	bookkeeper	login	authentication	bookkeeper logged in	10.17.12.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-08 16:11:11.494482
102	6	council1	login	authentication	council1 logged in	10.19.233.134	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-08 16:14:15.558069
105	6	council1	logout	authentication	council1 logged out	10.23.202.200	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-08 16:15:19.410087
108	4	treasurer	login	authentication	treasurer logged in	10.19.233.134	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 05:39:23.177377
111	4	treasurer	logout	authentication	treasurer logged out	10.23.4.2	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 06:05:23.179489
114	5	bookkeeper	login	authentication	bookkeeper logged in	10.18.165.136	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 06:06:47.728372
117	5	bookkeeper	login	authentication	bookkeeper logged in	10.18.165.136	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 12:40:10.027838
120	4	treasurer	login	authentication	treasurer logged in	10.23.202.200	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 12:41:02.492624
123	1	superadmin	login	authentication	superadmin logged in	10.23.4.2	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 12:43:21.437226
126	4	treasurer	login	authentication	treasurer logged in	10.18.165.136	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	2026-03-10 15:56:38.60517
129	7	approver	logout	authentication	approver logged out	10.23.4.2	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 16:06:05.533885
132	4	treasurer	login	authentication	treasurer logged in	10.17.174.195	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 16:17:01.988362
135	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.23.4.2	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 16:34:46.900396
138	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.17.12.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 16:34:47.557888
141	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.19.233.134	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 16:34:48.297398
144	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.18.165.136	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 16:34:49.104846
147	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.17.174.195	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 16:34:49.761276
150	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.18.165.136	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 16:34:50.477255
153	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.19.233.134	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 16:34:51.131321
156	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.19.233.134	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 16:39:42.275825
159	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.17.12.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 16:39:42.94358
162	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.18.165.136	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 16:39:43.620851
174	4	treasurer	logout	authentication	treasurer logged out	10.19.233.134	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 16:40:01.355481
76	4	treasurer	logout	authentication	treasurer logged out	10.23.4.2	PostmanRuntime/7.52.0	2026-03-08 13:27:57.98483
79	7	approver	login	authentication	approver logged in	10.23.202.200	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-08 13:57:41.553646
82	5	bookkeeper	login	authentication	bookkeeper logged in	10.23.202.200	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-08 15:26:43.278996
85	1	superadmin	login	authentication	superadmin logged in	10.18.165.136	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-08 15:36:59.297447
88	1	superadmin	login	authentication	superadmin logged in	10.18.165.136	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-08 16:01:15.545104
91	1	superadmin	login	authentication	superadmin logged in	10.23.202.200	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-08 16:08:15.795753
94	1	superadmin	logout	authentication	superadmin logged out	10.23.202.200	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-08 16:10:26.625387
97	7	approver	login	authentication	approver logged in	10.19.233.134	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-08 16:10:58.094979
100	5	bookkeeper	logout	authentication	bookkeeper logged out	10.23.202.200	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-08 16:11:19.990875
73	4	treasurer	login	authentication	treasurer logged in	10.19.233.134	PostmanRuntime/7.52.0	2026-03-08 11:42:01.138019
103	1	superadmin	login	authentication	superadmin logged in	10.19.233.134	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-08 16:14:40.59708
106	1	superadmin	login	authentication	superadmin logged in	10.19.233.134	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-08 16:15:25.943372
109	4	treasurer	logout	authentication	treasurer logged out	10.23.4.2	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 05:39:36.845828
112	4	treasurer	login	authentication	treasurer logged in	10.18.165.136	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 06:05:57.976371
115	5	bookkeeper	logout	authentication	bookkeeper logged out	10.23.4.2	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 06:06:58.895433
118	5	bookkeeper	INSERT	Collection Management	A review comment has been successfully submitted for Collection record (ID: 13).	10.18.165.136	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 12:40:41.196983
121	4	treasurer	UPDATE	Budget Management	Budget entry has been successfully updated.	10.23.4.2	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 12:42:12.694749
124	4	treasurer	login	authentication	treasurer logged in	10.18.165.136	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 15:40:05.212711
127	4	treasurer	logout	authentication	treasurer logged out	10.19.233.134	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 16:04:30.812279
130	4	treasurer	login	authentication	treasurer logged in	10.19.233.134	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 16:11:06.937377
133	4	treasurer	UPDATE	Disbursement Management	Disbursement record has been successfully updated.	10.19.233.134	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 16:26:53.295485
136	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.19.233.134	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 16:34:47.123896
139	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.18.165.136	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 16:34:47.774661
142	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.18.165.136	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 16:34:48.518405
145	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.18.165.136	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 16:34:49.325234
148	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.23.4.2	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 16:34:49.989481
151	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.17.174.195	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 16:34:50.691414
154	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.23.202.200	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 16:39:41.858057
157	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.17.174.195	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 16:39:42.49017
160	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.17.12.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 16:39:43.164245
175	4	treasurer	login	authentication	treasurer logged in	10.19.233.134	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 16:40:41.618181
164	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.19.233.134	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 16:39:44.04936
165	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.19.233.134	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 16:39:44.281551
166	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.23.202.200	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 16:39:44.490872
167	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.23.4.2	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 16:39:44.717991
168	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.23.4.2	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 16:39:44.944429
169	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.18.165.136	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 16:39:45.166236
170	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.17.174.195	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 16:39:45.388531
171	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.18.165.136	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 16:39:45.600153
172	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.19.233.134	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 16:39:45.822784
173	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.23.202.200	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 16:39:46.049473
176	4	treasurer	UPDATE	Budget Management	Budget entry has been successfully updated.	10.17.12.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 16:43:22.093029
177	4	treasurer	login	authentication	treasurer logged in	10.23.202.200	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 23:56:23.531596
178	4	treasurer	logout	authentication	treasurer logged out	10.23.4.2	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 23:59:05.591434
179	4	treasurer	logout	authentication	treasurer logged out	10.17.174.195	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 23:59:05.916982
180	1	superadmin	login	authentication	superadmin logged in	10.23.4.2	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-10 23:59:16.290305
181	1	superadmin	logout	authentication	superadmin logged out	10.19.233.134	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 00:00:35.042787
182	4	treasurer	login	authentication	treasurer logged in	10.23.4.2	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 00:00:47.800075
183	4	treasurer	logout	authentication	treasurer logged out	10.23.4.2	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 00:08:35.773807
184	4	treasurer	logout	authentication	treasurer logged out	10.17.174.195	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 00:08:36.782298
185	4	treasurer	login	authentication	treasurer logged in	10.19.233.134	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 00:09:08.136727
186	4	treasurer	logout	authentication	treasurer logged out	10.18.165.136	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 00:12:34.118631
187	4	treasurer	logout	authentication	treasurer logged out	10.23.4.2	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 00:14:17.997005
188	4	treasurer	logout	authentication	treasurer logged out	10.17.12.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 00:14:18.098886
189	4	treasurer	login	authentication	treasurer logged in	10.17.174.195	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 00:38:18.405527
190	4	treasurer	login	authentication	treasurer logged in	10.17.174.195	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 01:41:14.960115
191	4	treasurer	login	authentication	treasurer logged in	10.19.233.134	Mozilla/5.0 (Linux; Android 14; RMX3930 Build/UP1A.231005.007; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/145.0.7632.159 Mobile Safari/537.36 [FB_IAB/FB4A;FBAV/551.0.0.48.62;]	2026-03-11 01:51:27.580294
192	4	treasurer	logout	authentication	treasurer logged out	10.18.165.136	Mozilla/5.0 (Linux; Android 14; RMX3930 Build/UP1A.231005.007; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/145.0.7632.159 Mobile Safari/537.36 [FB_IAB/FB4A;FBAV/551.0.0.48.62;]	2026-03-11 01:54:38.894582
193	1	superadmin	login	authentication	superadmin logged in	10.17.174.195	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-03-11 02:01:18.794129
194	7	approver	login	authentication	approver logged in	10.17.12.130	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-03-11 02:14:05.507044
195	7	approver	logout	authentication	approver logged out	10.19.233.134	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-03-11 02:27:26.348743
196	4	treasurer	login	authentication	treasurer logged in	10.18.165.136	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-03-11 02:27:34.206034
197	4	treasurer	login	authentication	treasurer logged in	10.17.12.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 02:34:45.293212
198	4	treasurer	INSERT	DFUR Project Management	A new DFUR project record has been successfully recorded in the system.	10.18.165.136	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-03-11 02:46:32.497461
199	2	kapitan	login	authentication	kapitan logged in	10.19.233.134	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 02:53:02.655276
200	4	treasurer	login	authentication	treasurer logged in	10.23.4.2	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 02:53:23.191254
201	4	treasurer	INSERT	Collection Management	A new collection record has been successfully recorded in the system.	10.19.233.134	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 02:54:15.198053
202	4	treasurer	logout	authentication	treasurer logged out	10.23.202.200	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 02:54:21.311922
203	5	bookkeeper	login	authentication	bookkeeper logged in	10.17.12.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 02:55:00.872254
204	5	bookkeeper	logout	authentication	bookkeeper logged out	10.17.174.195	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 02:57:25.73102
205	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.23.4.2	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:01:34.258028
206	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.17.12.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:01:34.491845
207	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.23.202.200	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:01:34.751405
329	4	treasurer	INSERT	Disbursement Management	A new disbursement record has been successfully recorded in the system.	10.21.153.68	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-03-14 05:52:33.299248
208	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.18.165.136	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:01:34.99387
209	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.18.165.136	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:01:35.240666
210	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.17.12.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:01:35.831871
211	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.23.4.2	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:01:43.266067
212	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.17.12.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:01:46.363482
213	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.23.202.200	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:01:57.243416
214	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.18.165.136	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:01:58.197188
215	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.18.165.136	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:01:59.395467
216	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.17.174.195	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:02:02.221238
217	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.18.165.136	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:02:04.667563
218	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.23.202.200	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:02:08.622956
219	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.17.174.195	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:02:09.612698
220	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.17.12.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:02:14.854602
221	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.19.233.134	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:02:17.011995
222	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.18.165.136	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:02:29.838156
223	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.23.4.2	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:02:30.078358
224	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.18.165.136	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:02:30.319021
225	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.23.4.2	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:02:30.558124
226	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.17.12.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:02:30.777707
227	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.23.202.200	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:02:31.033358
228	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.17.12.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:02:31.783099
229	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.18.165.136	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:02:32.367458
230	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.23.4.2	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:02:32.620477
231	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.19.233.134	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:02:33.831458
232	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.18.165.136	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:02:34.038266
233	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.18.165.136	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:02:34.293064
234	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.18.165.136	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:02:34.545238
235	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.19.233.134	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:07:30.625676
236	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.23.202.200	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:07:32.298305
237	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.23.4.2	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:07:33.16721
238	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.17.12.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:07:34.500157
239	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.19.233.134	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:07:35.274258
240	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.19.233.134	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:07:35.656258
241	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.23.202.200	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:07:36.602593
242	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.23.4.2	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:07:38.893844
243	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.17.174.195	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:07:39.713538
244	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.23.202.200	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:07:40.081468
245	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.17.174.195	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:07:40.424559
246	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.23.4.2	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:07:40.790559
247	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.19.233.134	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:07:41.005025
248	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.19.233.134	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:07:44.047228
249	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.23.202.200	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:07:46.361197
250	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.23.4.2	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:07:47.502552
251	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.23.4.2	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:07:48.396474
252	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.17.174.195	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:07:48.991485
253	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.23.202.200	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:07:49.415862
254	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.17.12.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:07:49.883065
255	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.17.12.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:07:50.14334
256	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.19.233.134	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:07:50.358284
257	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.17.174.195	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:07:50.577098
258	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.18.165.136	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:07:51.145617
259	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.18.165.136	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:07:52.807968
260	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.18.165.136	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:07:53.626165
261	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.18.165.136	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:07:53.972809
262	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.23.202.200	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:07:54.269536
263	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.18.165.136	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:07:54.785489
264	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.19.233.134	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:07:55.550442
265	4	treasurer	INSERT_FAILED	Budget Management	Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.23.202.200	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:14:41.849182
266	4	treasurer	INSERT_FAILED	Budget Management	Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.23.202.200	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:14:43.097533
267	4	treasurer	INSERT_FAILED	Budget Management	Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.17.174.195	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:14:44.37687
268	4	treasurer	INSERT_FAILED	Budget Management	Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.17.174.195	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:14:45.52815
269	4	treasurer	INSERT_FAILED	Budget Management	Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.17.174.195	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:14:46.884679
270	4	treasurer	INSERT_FAILED	Budget Management	Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.23.202.200	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:14:47.862158
271	4	treasurer	INSERT_FAILED	Budget Management	Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.17.12.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:14:48.384855
272	4	treasurer	INSERT_FAILED	Budget Management	Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.23.202.200	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:14:49.427846
273	4	treasurer	INSERT_FAILED	Budget Management	Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.17.174.195	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:14:49.782361
274	4	treasurer	INSERT_FAILED	Budget Management	Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.17.174.195	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:14:50.624302
275	4	treasurer	INSERT_FAILED	Budget Management	Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.23.4.2	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:14:51.031168
276	4	treasurer	INSERT_FAILED	Budget Management	Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.23.4.2	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:14:51.381195
277	4	treasurer	INSERT_FAILED	Budget Management	Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.23.202.200	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:14:51.831984
278	4	treasurer	INSERT_FAILED	Budget Management	Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.17.174.195	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:14:55.651886
279	4	treasurer	INSERT_FAILED	Budget Management	Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.17.174.195	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:14:56.433754
280	4	treasurer	INSERT_FAILED	Budget Management	Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.17.12.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:14:58.084013
281	4	treasurer	INSERT_FAILED	Budget Management	Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.17.174.195	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:14:59.495141
282	4	treasurer	INSERT_FAILED	Budget Management	Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.18.165.136	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:15:03.575642
283	4	treasurer	INSERT_FAILED	Budget Management	Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.23.202.200	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:15:05.509852
284	4	treasurer	INSERT_FAILED	Budget Management	Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.17.174.195	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:15:06.293168
285	4	treasurer	INSERT_FAILED	Budget Management	Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.17.12.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:15:19.563894
286	4	treasurer	INSERT_FAILED	Budget Management	Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.23.202.200	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:15:19.920914
287	4	treasurer	INSERT_FAILED	Budget Management	Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.17.174.195	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:15:20.360381
288	4	treasurer	INSERT_FAILED	Budget Management	Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.17.12.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:15:20.761753
289	4	treasurer	INSERT_FAILED	Budget Management	Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.23.202.200	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:15:21.099619
290	4	treasurer	INSERT_FAILED	Budget Management	Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.23.202.200	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:15:21.446892
291	4	treasurer	INSERT_FAILED	Budget Management	Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.18.165.136	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:15:21.791593
292	4	treasurer	INSERT_FAILED	Budget Management	Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.18.165.136	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:15:22.029158
293	4	treasurer	INSERT_FAILED	Budget Management	Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.17.174.195	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:15:22.24565
294	4	treasurer	INSERT_FAILED	Budget Management	Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.17.12.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:15:22.489666
295	4	treasurer	INSERT_FAILED	Budget Management	Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.17.174.195	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:15:22.778826
296	4	treasurer	INSERT_FAILED	Budget Management	Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.18.165.136	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:15:23.072201
297	4	treasurer	INSERT_FAILED	Budget Management	Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.17.174.195	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:15:23.329168
298	4	treasurer	INSERT_FAILED	Budget Management	Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.17.174.195	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:15:23.599575
299	4	treasurer	INSERT_FAILED	Budget Management	Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.17.174.195	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:15:23.845522
300	4	treasurer	INSERT_FAILED	Budget Management	Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.17.174.195	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:15:24.118869
301	4	treasurer	INSERT_FAILED	Budget Management	Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.23.4.2	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:15:24.522601
302	4	treasurer	INSERT_FAILED	Budget Management	Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.19.233.134	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:15:25.017973
303	4	treasurer	INSERT_FAILED	Budget Management	Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.17.12.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:15:25.309951
304	4	treasurer	INSERT_FAILED	Budget Management	Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.23.202.200	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:15:25.930491
305	4	treasurer	INSERT_FAILED	Budget Management	Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.17.174.195	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:15:26.181531
306	4	treasurer	INSERT_FAILED	Budget Management	Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.17.12.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:15:26.451189
307	4	treasurer	INSERT_FAILED	Budget Management	Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.19.233.134	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:15:26.712978
308	4	treasurer	INSERT_FAILED	Budget Management	Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.23.4.2	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:15:26.980423
309	4	treasurer	INSERT_FAILED	Budget Management	Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.17.174.195	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:15:27.293415
310	4	treasurer	INSERT_FAILED	Budget Management	Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.17.174.195	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:15:27.685554
311	4	treasurer	INSERT_FAILED	Budget Management	Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.17.174.195	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:15:27.96847
312	4	treasurer	INSERT_FAILED	Budget Management	Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.23.202.200	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:15:28.215345
313	4	treasurer	INSERT_FAILED	Budget Management	Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.18.165.136	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:15:28.483539
314	4	treasurer	INSERT_FAILED	Budget Management	Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.17.12.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 03:15:28.891621
315	4	treasurer	logout	authentication	treasurer logged out	10.18.165.136	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 06:59:52.998204
316	7	approver	login	authentication	approver logged in	10.23.4.2	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 07:00:06.806878
317	7	approver	logout	authentication	approver logged out	10.17.174.195	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 07:00:20.202468
318	4	treasurer	login	authentication	treasurer logged in	10.19.233.134	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 07:00:31.581241
319	7	approver	login	authentication	approver logged in	10.23.4.2	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 12:57:26.910481
320	7	approver	logout	authentication	approver logged out	10.23.202.200	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 12:57:59.192307
321	1	superadmin	login	authentication	superadmin logged in	10.23.202.200	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 12:58:09.066391
322	4	treasurer	login	authentication	treasurer logged in	10.18.165.136	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-11 12:58:47.687107
323	4	treasurer	login	authentication	treasurer logged in	10.18.41.69	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-03-14 03:17:46.371841
324	4	treasurer	logout	authentication	treasurer logged out	10.18.41.69	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-03-14 03:19:45.77774
325	4	treasurer	login	authentication	treasurer logged in	10.22.61.68	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-03-14 03:20:56.1984
326	4	treasurer	logout	authentication	treasurer logged out	10.16.201.197	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-03-14 03:27:08.797719
327	4	treasurer	login	authentication	treasurer logged in	10.21.153.68	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-03-14 05:50:50.576568
328	4	treasurer	INSERT	Collection Management	A new collection record has been successfully recorded in the system.	10.21.180.131	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-03-14 05:51:48.705545
365	4	treasurer	login	authentication	treasurer logged in	10.18.50.129	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-03-14 06:21:39.524051
330	4	treasurer	INSERT	Collection Management	A new collection record has been successfully recorded in the system.	10.18.41.69	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-03-14 05:55:45.497158
331	4	treasurer	DELETE	Collection Management	Collection record has been successfully deleted from the system.	10.22.61.68	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-03-14 05:55:53.701899
332	4	treasurer	INSERT	Collection Management	A new collection record has been successfully recorded in the system.	10.22.61.68	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-03-14 05:56:08.996969
333	4	treasurer	DELETE	Collection Management	Collection record has been successfully deleted from the system.	10.18.50.129	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-03-14 05:56:59.999649
334	4	treasurer	logout	authentication	treasurer logged out	10.21.153.68	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-03-14 06:01:05.146742
335	7	approver	login	authentication	approver logged in	10.21.180.131	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-03-14 06:01:19.018623
336	2	kapitan	login	authentication	kapitan logged in	10.22.61.68	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-14 06:01:26.509435
337	5	bookkeeper	INSERT	Collection Management	A review comment has been successfully submitted for Collection record (ID: 16).	10.16.201.197	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-03-14 06:03:35.195513
338	7	approver	logout	authentication	approver logged out	10.22.61.68	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-03-14 06:03:45.737561
339	4	treasurer	login	authentication	treasurer logged in	10.16.201.197	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-03-14 06:03:58.997222
340	4	treasurer	logout	authentication	treasurer logged out	10.18.41.69	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-03-14 06:04:15.964569
341	4	treasurer	login	authentication	treasurer logged in	10.21.153.68	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-03-14 06:04:29.018086
342	4	treasurer	logout	authentication	treasurer logged out	10.16.201.197	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-03-14 06:04:46.407269
343	1	superadmin	login	authentication	superadmin logged in	10.21.153.68	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-03-14 06:05:14.574766
344	7	approver	login	authentication	approver logged in	10.21.153.68	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-14 06:07:04.008426
345	6	council1	login	authentication	council1 logged in	10.16.201.197	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-03-14 06:11:57.526575
346	7	approver	logout	authentication	approver logged out	10.21.153.68	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-14 06:12:24.585425
347	6	council1	logout	authentication	council1 logged out	10.18.50.129	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-03-14 06:13:02.813346
348	7	approver	login	authentication	approver logged in	10.18.50.129	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-03-14 06:13:15.678537
349	6	council1	login	authentication	council1 logged in	10.21.153.68	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-14 06:13:29.324392
350	7	approver	APPROVAL	Collection Management	Collection record approval status has been successfully updated to 'approved'.	10.21.153.68	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-03-14 06:14:35.396754
351	7	approver	APPROVAL	DFUR Project Management	DFUR project record approval status has been successfully updated to 'approved'.	10.21.180.131	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-03-14 06:15:16.597101
352	6	council1	logout	authentication	council1 logged out	10.18.41.69	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-14 06:15:31.921208
353	7	approver	logout	authentication	approver logged out	10.22.61.68	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-03-14 06:15:40.594911
354	4	treasurer	login	authentication	treasurer logged in	10.18.50.129	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-14 06:15:45.701741
355	4	treasurer	login	authentication	treasurer logged in	10.18.50.129	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-03-14 06:15:52.390659
356	4	treasurer	logout	authentication	treasurer logged out	10.21.153.68	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-03-14 06:17:05.145131
357	4	treasurer	login	authentication	treasurer logged in	10.21.180.131	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36	2026-03-14 06:17:16.378248
358	7	approver	login	authentication	approver logged in	10.18.41.69	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-03-14 06:17:23.974172
359	5	bookkeeper	INSERT	Collection Management	A review comment has been successfully submitted for Collection record (ID: 16).	10.18.50.129	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-03-14 06:18:03.997181
360	7	approver	logout	authentication	approver logged out	10.18.50.129	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-03-14 06:18:09.391771
361	4	treasurer	login	authentication	treasurer logged in	10.21.180.131	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-03-14 06:18:22.495837
362	4	treasurer	UPDATE	Collection Management	Collection record has been successfully updated.	10.22.61.68	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-03-14 06:19:56.69736
363	4	treasurer	logout	authentication	treasurer logged out	10.21.153.68	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-14 06:20:22.397814
364	4	treasurer	logout	authentication	treasurer logged out	10.18.41.69	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-03-14 06:20:22.742619
366	4	treasurer	logout	authentication	treasurer logged out	10.21.180.131	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-03-14 06:32:53.224106
367	7	approver	login	authentication	approver logged in	10.21.153.68	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-03-14 06:33:10.080674
368	7	approver	logout	authentication	approver logged out	10.22.61.68	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-03-14 06:33:37.729622
369	4	treasurer	login	authentication	treasurer logged in	10.18.50.129	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-03-14 06:33:57.778782
370	4	treasurer	logout	authentication	treasurer logged out	10.22.61.68	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-03-14 06:34:45.1479
371	4	treasurer	login	authentication	treasurer logged in	10.21.153.68	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-03-14 06:35:53.925563
372	4	treasurer	login	authentication	treasurer logged in	10.16.201.197	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-14 06:39:14.897063
373	4	treasurer	logout	authentication	treasurer logged out	10.16.201.197	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-14 06:40:19.71094
374	4	treasurer	login	authentication	treasurer logged in	10.16.201.197	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-03-14 06:40:32.21326
375	4	treasurer	login	authentication	treasurer logged in	10.18.41.69	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-14 06:40:49.470016
376	4	treasurer	logout	authentication	treasurer logged out	10.21.180.131	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-14 06:42:40.096061
377	4	treasurer	login	authentication	treasurer logged in	10.21.180.131	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-14 06:43:04.28001
378	4	treasurer	logout	authentication	treasurer logged out	10.21.180.131	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-03-14 06:44:25.773867
379	4	treasurer	login	authentication	treasurer logged in	10.22.61.68	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-03-14 06:47:18.690436
380	4	treasurer	logout	authentication	treasurer logged out	10.18.50.129	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-14 06:48:21.882444
381	4	treasurer	logout	authentication	treasurer logged out	10.21.153.68	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36	2026-03-14 06:50:12.619875
382	4	treasurer	login	authentication	treasurer logged in	10.21.180.131	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-14 06:53:06.194335
383	4	treasurer	logout	authentication	treasurer logged out	10.21.180.131	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-14 07:01:45.516623
384	4	treasurer	logout	authentication	treasurer logged out	10.18.41.69	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-03-14 07:02:41.036183
385	6	council1	login	authentication	council1 logged in	10.18.41.69	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-14 07:02:51.482406
386	7	approver	login	authentication	approver logged in	10.18.50.129	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-03-14 07:04:18.198266
387	6	council1	logout	authentication	council1 logged out	10.22.61.68	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-14 07:04:25.37059
388	4	treasurer	login	authentication	treasurer logged in	10.16.201.197	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-14 07:04:42.58284
389	4	treasurer	logout	authentication	treasurer logged out	10.18.41.69	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-14 07:05:26.815193
390	6	council1	login	authentication	council1 logged in	10.21.180.131	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-14 07:05:36.420115
391	4	treasurer	login	authentication	treasurer logged in	10.18.41.69	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-14 07:06:23.779028
392	5	bookkeeper	INSERT	DFUR Project Management	A review comment has been successfully submitted for DFUR project record (ID: 3).	10.18.41.69	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-03-14 07:08:09.690256
393	7	approver	logout	authentication	approver logged out	10.21.180.131	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-03-14 07:08:25.361932
394	7	approver	login	authentication	approver logged in	10.21.180.131	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-03-14 07:08:29.426427
395	6	council1	login	authentication	council1 logged in	10.22.61.68	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36	2026-03-14 07:08:38.506869
396	7	approver	logout	authentication	approver logged out	10.22.61.68	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-03-14 07:08:44.183734
397	6	council1	login	authentication	council1 logged in	10.21.153.68	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36	2026-03-14 07:08:58.67002
398	6	council1	logout	authentication	council1 logged out	10.16.201.197	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36	2026-03-14 07:10:32.142434
399	4	treasurer	login	authentication	treasurer logged in	10.18.41.69	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36	2026-03-14 07:10:42.989752
400	4	treasurer	login	authentication	treasurer logged in	10.18.50.129	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-03-14 07:10:43.70126
401	4	treasurer	logout	authentication	treasurer logged out	10.18.50.129	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36	2026-03-14 07:10:52.95194
402	1	superadmin	login	authentication	superadmin logged in	10.16.201.197	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36	2026-03-14 07:11:05.278657
403	6	council1	logout	authentication	council1 logged out	10.21.180.131	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36	2026-03-14 07:12:03.140897
404	4	treasurer	logout	authentication	treasurer logged out	10.21.153.68	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-03-14 07:12:04.779859
405	7	approver	login	authentication	approver logged in	10.18.41.69	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-03-14 07:12:09.526533
406	7	approver	logout	authentication	approver logged out	10.21.180.131	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-03-14 07:12:18.304461
407	7	approver	login	authentication	approver logged in	10.22.61.68	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-03-14 07:12:25.470217
408	2	kapitan	login	authentication	kapitan logged in	10.18.41.69	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36	2026-03-14 07:12:28.080298
409	7	approver	logout	authentication	approver logged out	10.21.153.68	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-03-14 07:12:32.876839
410	4	treasurer	logout	authentication	treasurer logged out	10.22.61.68	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36	2026-03-14 07:12:43.657666
411	2	kapitan	login	authentication	kapitan logged in	10.18.50.129	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36	2026-03-14 07:12:54.682111
412	1	superadmin	login	authentication	superadmin logged in	10.18.41.69	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-03-14 07:12:58.892841
413	5	bookkeeper	login	authentication	bookkeeper logged in	10.18.50.129	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-03-14 07:14:00.280053
414	5	bookkeeper	logout	authentication	bookkeeper logged out	10.21.180.131	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-03-14 07:17:09.987738
415	4	treasurer	login	authentication	treasurer logged in	10.22.61.68	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-03-14 10:47:28.384023
416	4	treasurer	login	authentication	treasurer logged in	10.18.41.69	Mozilla/5.0 (Linux; Android 14; NDL-W09 Build/HONORNDL-W09; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/145.0.7632.159 Safari/537.36 [FB_IAB/FB4A;FBAV/551.0.0.48.62;]	2026-03-14 10:47:32.316219
417	4	treasurer	login	authentication	treasurer logged in	10.18.41.69	Mozilla/5.0 (Linux; Android 14; NDL-W09 Build/HONORNDL-W09; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/145.0.7632.159 Safari/537.36 [FB_IAB/FB4A;FBAV/551.0.0.48.62;]	2026-03-14 10:47:32.875853
418	4	treasurer	INSERT	Collection Management	A new collection record has been successfully recorded in the system.	10.18.41.69	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-03-14 10:48:45.798547
419	4	treasurer	login	authentication	treasurer logged in	10.22.61.68	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-03-15 03:24:51.12471
420	4	treasurer	DELETE	Collection Management	Collection record has been successfully deleted from the system.	10.22.61.68	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-03-15 03:25:04.899744
421	4	treasurer	login	authentication	treasurer logged in	10.21.180.131	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-16 03:09:23.381216
422	4	treasurer	logout	authentication	treasurer logged out	10.21.180.131	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-16 05:03:27.522126
423	5	bookkeeper	login	authentication	bookkeeper logged in	10.18.50.129	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-16 05:03:39.480138
424	5	bookkeeper	logout	authentication	bookkeeper logged out	10.18.41.69	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-16 05:04:37.163237
425	7	approver	login	authentication	approver logged in	10.18.41.69	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-16 05:04:52.222453
426	7	approver	logout	authentication	approver logged out	10.21.180.131	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-16 05:05:33.944371
427	6	council1	login	authentication	council1 logged in	10.22.61.68	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-16 05:07:11.026555
428	6	council1	logout	authentication	council1 logged out	10.16.201.197	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-16 05:28:35.631603
429	5	bookkeeper	login	authentication	bookkeeper logged in	10.21.153.68	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-16 05:28:45.11284
430	5	bookkeeper	logout	authentication	bookkeeper logged out	10.18.41.69	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-16 05:28:58.085146
431	7	approver	login	authentication	approver logged in	10.18.50.129	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-16 05:29:05.39252
432	7	approver	logout	authentication	approver logged out	10.21.153.68	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-16 05:31:10.126928
433	4	treasurer	login	authentication	treasurer logged in	10.18.50.129	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-16 05:31:19.48101
434	4	treasurer	logout	authentication	treasurer logged out	10.16.201.197	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	2026-03-16 05:32:18.441306
435	5	bookkeeper	INSERT	DFUR Project Management	A review comment has been successfully submitted for DFUR Project record (ID: 4).	127.0.0.1	PostmanRuntime/7.52.0	2026-03-16 08:19:33.55378
436	1	superadmin	login	authentication	superadmin logged in	10.17.247.68	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-21 10:50:52.843387
437	1	superadmin	logout	authentication	superadmin logged out	10.17.247.68	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-21 10:50:58.796248
438	4	treasurer	login	authentication	treasurer logged in	10.17.247.68	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-21 10:51:04.80688
439	4	treasurer	INSERT	Budget Management	A new budget entry has been successfully recorded in the system.	10.17.237.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-21 10:51:35.394969
440	4	treasurer	INSERT	Collection Management	A new collection record has been successfully recorded in the system.	10.18.230.65	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-21 10:51:54.498416
441	4	treasurer	INSERT	Disbursement Management	A new disbursement record has been successfully recorded in the system.	10.17.194.6	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-21 10:52:16.195783
442	4	treasurer	INSERT	DFUR Project Management	A new DFUR project record has been successfully recorded in the system.	10.17.194.6	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-21 10:52:50.996636
443	4	treasurer	logout	authentication	treasurer logged out	10.18.230.65	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-21 10:52:59.74401
444	4	treasurer	login	authentication	treasurer logged in	10.17.84.4	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-21 16:26:31.456327
445	4	treasurer	logout	authentication	treasurer logged out	10.17.247.68	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-21 16:44:12.777686
446	5	bookkeeper	login	authentication	bookkeeper logged in	10.17.247.68	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-21 16:44:21.353165
447	5	bookkeeper	logout	authentication	bookkeeper logged out	10.17.247.68	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-21 16:51:37.009334
448	4	treasurer	login	authentication	treasurer logged in	10.18.230.65	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-21 16:51:50.307559
449	4	treasurer	UPDATE	Collection Management	Collection record has been successfully updated.	10.17.194.6	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-21 17:06:42.097047
450	4	treasurer	UPDATE	Collection Management	Collection record has been successfully updated.	10.17.194.6	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-21 17:08:01.996074
451	4	treasurer	UPDATE	Disbursement Management	Disbursement record has been successfully updated.	10.17.194.6	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-21 17:11:24.796138
452	4	treasurer	UPDATE	Collection Management	Collection record has been successfully updated.	10.18.230.65	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-21 17:12:36.197371
453	5	bookkeeper	login	authentication	bookkeeper logged in	10.18.230.65	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-23 15:36:50.41456
454	5	bookkeeper	INSERT_FAILED	Collection Management	Review comment submission failed for Collection record (ID: 12). Please try again or contact the system administrator.	10.17.84.4	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-23 16:00:25.595048
455	5	bookkeeper	INSERT_FAILED	Collection Management	Review comment submission failed for Collection record (ID: 12). Please try again or contact the system administrator.	10.21.153.70	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-23 16:00:35.3957
456	5	bookkeeper	INSERT_FAILED	Collection Management	Review comment submission failed for Collection record (ID: 12). Please try again or contact the system administrator.	10.17.247.68	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-23 16:04:30.498908
457	5	bookkeeper	INSERT	Disbursement Management	A review comment has been successfully submitted for Disbursement record (ID: 9).	10.18.230.65	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-23 16:08:48.995709
458	5	bookkeeper	INSERT_FAILED	DFUR Project Management	Review comment submission failed for DFUR Project record (ID: 65). Please try again or contact the system administrator.	10.18.230.65	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-23 16:19:33.096425
459	5	bookkeeper	logout	authentication	bookkeeper logged out	10.17.237.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-23 16:20:27.362136
460	4	treasurer	login	authentication	treasurer logged in	10.17.84.4	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-23 16:20:35.746651
461	4	treasurer	logout	authentication	treasurer logged out	10.17.237.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-23 16:22:01.509733
462	7	approver	login	authentication	approver logged in	10.17.247.68	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-23 16:22:10.916173
463	5	approver	INSERT_FAILED	Collection Management	Review comment submission failed for Collection record (ID: 12). Please try again or contact the system administrator.	10.17.237.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-23 16:29:36.19922
464	5	approver	INSERT	Disbursement Management	A review comment has been successfully submitted for Disbursement record (ID: 8).	10.17.247.68	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-23 16:29:46.592722
465	7	approver	logout	authentication	approver logged out	10.17.84.4	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-23 16:31:01.103198
466	4	treasurer	login	authentication	treasurer logged in	10.17.84.4	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-23 16:31:08.116253
467	4	treasurer	INSERT	DFUR Project Management	A new DFUR project record has been successfully recorded in the system.	10.18.230.65	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-23 16:33:14.697455
468	4	treasurer	logout	authentication	treasurer logged out	10.21.153.70	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-23 16:33:34.380921
469	7	approver	login	authentication	approver logged in	10.17.84.4	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-23 16:33:42.649011
470	5	approver	INSERT_FAILED	DFUR Project Management	Review comment submission failed for DFUR Project record (ID: 66). Please try again or contact the system administrator.	10.21.153.70	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-23 16:34:00.496635
471	7	approver	logout	authentication	approver logged out	10.21.153.70	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-23 16:36:02.5876
472	4	treasurer	login	authentication	treasurer logged in	10.17.247.68	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-23 16:36:09.514444
473	4	treasurer	INSERT	DFUR Project Management	A new DFUR project record has been successfully recorded in the system.	10.17.84.4	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-23 16:36:44.698504
474	4	treasurer	INSERT	DFUR Project Management	A new DFUR project record has been successfully recorded in the system.	10.17.194.6	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-23 16:37:22.707763
475	4	treasurer	logout	authentication	treasurer logged out	10.17.247.68	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-23 16:37:25.536371
476	7	approver	login	authentication	approver logged in	10.17.84.4	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-23 16:37:31.542049
477	7	approver	logout	authentication	approver logged out	10.18.230.65	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-23 16:50:26.831483
478	5	bookkeeper	login	authentication	bookkeeper logged in	10.17.84.4	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-23 16:50:33.026762
479	5	bookkeeper	logout	authentication	bookkeeper logged out	10.17.237.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-23 16:56:25.318848
480	4	treasurer	login	authentication	treasurer logged in	10.18.230.65	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-23 16:56:31.155419
481	4	treasurer	logout	authentication	treasurer logged out	10.17.194.6	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-23 17:03:18.260005
482	7	approver	login	authentication	approver logged in	10.17.194.6	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-23 17:03:24.662021
483	7	approver	logout	authentication	approver logged out	10.18.230.65	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-23 17:04:15.524877
484	5	bookkeeper	login	authentication	bookkeeper logged in	10.17.84.4	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-23 17:04:20.312777
485	5	bookkeeper	logout	authentication	bookkeeper logged out	10.17.194.6	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-23 17:06:33.415665
486	7	approver	login	authentication	approver logged in	10.17.237.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-23 17:06:38.681071
487	5	approver	INSERT_FAILED	DFUR Project Management	Review comment submission failed for DFUR Project record (ID: 67). Please try again or contact the system administrator.	10.17.84.4	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-23 17:07:13.994753
488	7	approver	logout	authentication	approver logged out	10.21.153.70	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-23 17:12:01.89586
489	5	bookkeeper	login	authentication	bookkeeper logged in	10.17.247.68	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-23 17:12:07.217288
490	5	bookkeeper	INSERT_FAILED	DFUR Project Management	Review comment submission failed for DFUR Project record (ID: 68). Please try again or contact the system administrator.	10.18.230.65	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-23 17:12:15.295409
491	5	bookkeeper	INSERT_FAILED	DFUR Project Management	Review comment submission failed for DFUR Project record (ID: 68). Please try again or contact the system administrator.	10.21.153.70	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-23 17:12:49.200908
492	5	bookkeeper	INSERT_FAILED	DFUR Project Management	Review comment submission failed for DFUR Project record (ID: 68). Please try again or contact the system administrator.	10.17.194.6	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-23 17:13:27.800462
493	5	bookkeeper	INSERT_FAILED	DFUR Project Management	Review comment submission failed for DFUR Project record (ID: 60). Please try again or contact the system administrator.	10.17.247.68	PostmanRuntime/7.52.0	2026-03-23 17:14:44.598272
494	5	bookkeeper	INSERT_FAILED	DFUR Project Management	Review comment submission failed for DFUR Project record (ID: 68). Please try again or contact the system administrator.	10.21.153.70	PostmanRuntime/7.52.0	2026-03-23 17:15:50.899669
495	5	bookkeeper	logout	authentication	bookkeeper logged out	10.17.84.4	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-23 17:16:18.456935
496	4	treasurer	login	authentication	treasurer logged in	10.17.237.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-23 17:16:25.064789
497	4	treasurer	INSERT	DFUR Project Management	A new DFUR project record has been successfully recorded in the system.	10.17.84.4	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-23 17:16:52.093124
498	4	treasurer	logout	authentication	treasurer logged out	10.18.230.65	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-23 17:16:55.374902
499	5	bookkeeper	login	authentication	bookkeeper logged in	10.17.194.6	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-23 17:17:08.116176
500	5	bookkeeper	INSERT_FAILED	DFUR Project Management	Review comment submission failed for DFUR Project record (ID: 69). Please try again or contact the system administrator.	10.21.153.70	PostmanRuntime/7.52.0	2026-03-23 17:17:40.992978
501	4	treasurer	login	authentication	treasurer logged in	10.18.230.65	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-23 23:41:28.408833
502	4	treasurer	logout	authentication	treasurer logged out	10.17.84.4	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-24 01:06:22.43205
503	4	treasurer	login	authentication	treasurer logged in	10.21.153.70	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-24 12:15:57.731722
504	5	bookkeeper	INSERT_FAILED	Collection Management	Review comment submission failed for Collection record (ID: 141). Please try again or contact the system administrator.	127.0.0.1	PostmanRuntime/7.52.0	2026-03-24 12:43:19.315573
505	5	bookkeeper	INSERT_FAILED	Collection Management	Review comment submission failed for Collection record (ID: 141). Please try again or contact the system administrator.	127.0.0.1	PostmanRuntime/7.52.0	2026-03-24 12:46:20.152427
506	5	bookkeeper	INSERT_FAILED	Collection Management	Review comment submission failed for Collection record (ID: 141). Please try again or contact the system administrator.	127.0.0.1	PostmanRuntime/7.52.0	2026-03-24 13:14:08.311386
507	5	bookkeeper	INSERT	Collection Management	A review comment has been successfully submitted for Collection record (ID: 141).	127.0.0.1	PostmanRuntime/7.52.0	2026-03-24 13:16:00.788836
508	5	bookkeeper	INSERT	Disbursement Management	A review comment has been successfully submitted for Disbursement record (ID: 7).	127.0.0.1	PostmanRuntime/7.52.0	2026-03-24 13:19:53.295531
509	5	bookkeeper	INSERT_FAILED	DFUR Project Management	Review comment submission failed for DFUR Project record (ID: 3). Please try again or contact the system administrator.	127.0.0.1	PostmanRuntime/7.52.0	2026-03-24 13:25:51.547708
510	5	bookkeeper	INSERT_FAILED	DFUR Project Management	Review comment submission failed for DFUR Project record (ID: 3). Please try again or contact the system administrator.	127.0.0.1	PostmanRuntime/7.52.0	2026-03-24 13:28:32.185471
511	5	bookkeeper	INSERT	DFUR Project Management	A review comment has been successfully submitted for DFUR Project record (ID: 3).	127.0.0.1	PostmanRuntime/7.52.0	2026-03-24 13:39:50.019919
512	5	bookkeeper	INSERT	DFUR Project Management	A review comment has been successfully submitted for DFUR Project record (ID: 4).	127.0.0.1	PostmanRuntime/7.52.0	2026-03-24 13:42:21.497816
513	5	bookkeeper	INSERT	DFUR Project Management	A review comment has been successfully submitted for DFUR Project record (ID: 65).	127.0.0.1	PostmanRuntime/7.52.0	2026-03-24 13:42:42.992283
514	5	bookkeeper	INSERT	DFUR Project Management	A review comment has been successfully submitted for DFUR Project record (ID: 66).	127.0.0.1	PostmanRuntime/7.52.0	2026-03-24 13:43:01.081605
515	5	bookkeeper	INSERT	DFUR Project Management	A review comment has been successfully submitted for DFUR Project record (ID: 67).	127.0.0.1	PostmanRuntime/7.52.0	2026-03-24 13:43:31.923472
516	5	bookkeeper	INSERT	DFUR Project Management	A review comment has been successfully submitted for DFUR Project record (ID: 68).	127.0.0.1	PostmanRuntime/7.52.0	2026-03-24 13:43:52.014302
517	5	bookkeeper	INSERT	DFUR Project Management	A review comment has been successfully submitted for DFUR Project record (ID: 69).	127.0.0.1	PostmanRuntime/7.52.0	2026-03-24 13:44:13.374157
518	4	treasurer	login	authentication	treasurer logged in	10.17.247.68	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-24 13:45:12.907287
519	4	treasurer	logout	authentication	treasurer logged out	10.17.194.6	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-24 13:59:42.299509
520	4	treasurer	login	authentication	treasurer logged in	10.17.194.6	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-24 14:02:34.808239
521	5	bookkeeper	INSERT	Collection Management	A review comment has been successfully submitted for Collection record (ID: 137).	10.17.247.68	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-24 14:48:19.792525
522	4	treasurer	login	authentication	treasurer logged in	10.17.194.6	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-03-25 16:00:53.808834
523	4	treasurer	logout	authentication	treasurer logged out	10.18.230.65	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-03-25 16:02:09.015332
524	7	approver	login	authentication	approver logged in	10.17.237.130	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-03-25 16:03:25.200194
525	7	approver	logout	authentication	approver logged out	10.17.237.130	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-03-25 16:03:43.486678
526	4	treasurer	login	authentication	treasurer logged in	10.17.237.130	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-03-25 16:04:00.911841
527	4	treasurer	logout	authentication	treasurer logged out	10.18.230.65	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-03-25 16:26:31.845379
528	4	treasurer	login	authentication	treasurer logged in	10.16.84.1	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-03-26 10:14:29.553587
529	7	approver	login	authentication	approver logged in	10.16.84.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-26 16:16:05.612265
530	7	approver	logout	authentication	approver logged out	10.19.38.195	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-26 16:22:03.666959
531	5	bookkeeper	login	authentication	bookkeeper logged in	10.17.236.4	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-26 16:22:11.710447
532	5	bookkeeper	logout	authentication	bookkeeper logged out	10.16.84.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-26 16:26:32.962017
533	3	secretary	login	authentication	secretary logged in	10.17.247.71	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-26 16:26:45.190497
534	3	secretary	logout	authentication	secretary logged out	10.19.107.193	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-26 16:26:58.895911
535	6	council1	login	authentication	council1 logged in	10.17.236.4	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-26 16:27:04.452293
536	6	council1	logout	authentication	council1 logged out	10.19.38.195	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-26 16:36:33.000401
537	4	treasurer	login	authentication	treasurer logged in	10.19.38.195	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-03-26 16:36:39.502035
538	4	treasurer	login	authentication	treasurer logged in	10.19.38.195	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-01 04:04:21.092298
539	4	treasurer	login	authentication	treasurer logged in	10.17.194.9	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-03 13:26:44.927059
540	1	superadmin	login	authentication	superadmin logged in	10.24.4.132	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-05 08:19:51.636894
541	1	superadmin	logout	authentication	superadmin logged out	10.27.230.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-05 09:29:57.04444
542	4	treasurer	login	authentication	treasurer logged in	10.27.230.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-05 09:30:04.933211
543	4	treasurer	logout	authentication	treasurer logged out	10.25.60.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-05 09:31:15.371991
544	5	bookkeeper	login	authentication	bookkeeper logged in	10.24.4.132	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-05 09:31:25.483166
545	1	superadmin	login	authentication	superadmin logged in	10.27.230.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-05 09:44:27.436327
546	1	superadmin	logout	authentication	superadmin logged out	10.27.230.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-05 09:45:18.52969
547	10	encoder	login	authentication	encoder logged in	10.29.69.3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-05 09:45:30.635343
548	10	encoder	logout	authentication	encoder logged out	10.28.88.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-05 09:45:44.989132
549	1	superadmin	login	authentication	superadmin logged in	10.29.69.3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-05 09:45:50.734525
550	1	superadmin	logout	authentication	superadmin logged out	10.28.88.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-05 09:47:01.742314
551	11	checker	login	authentication	checker logged in	10.28.88.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-05 09:47:06.89473
552	5	bookkeeper	INSERT	Collection Management	A review comment has been successfully submitted for Collection record (ID: 13).	10.29.69.3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-05 10:10:22.895394
553	5	checker	INSERT	Collection Management	A review comment has been successfully submitted for Collection record (ID: 11).	10.29.69.3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-05 10:40:43.6926
554	5	checker	INSERT	DFUR Project Management	A review comment has been successfully submitted for DFUR Project record (ID: 3).	10.24.4.132	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-05 11:21:13.40197
555	5	bookkeeper	logout	authentication	bookkeeper logged out	10.28.88.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-05 14:35:29.642627
556	1	superadmin	login	authentication	superadmin logged in	10.29.69.3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-05 14:35:37.939628
557	1	superadmin	logout	authentication	superadmin logged out	10.24.4.132	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-05 14:37:11.76063
558	12	newapprover	login	authentication	newapprover logged in	10.24.4.132	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-05 14:37:24.583905
559	12	newapprover	logout	authentication	newapprover logged out	10.29.69.3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-05 14:37:48.997141
560	7	approver	login	authentication	approver logged in	10.24.4.132	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-05 14:37:55.432182
561	11	checker	logout	authentication	checker logged out	10.27.216.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-05 14:38:04.874388
562	12	newapprover	login	authentication	newapprover logged in	10.25.60.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-05 14:38:28.892497
563	5	approver	INSERT	DFUR Project Management	A review comment has been successfully submitted for DFUR Project record (ID: 65).	10.27.216.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-05 15:16:02.597295
564	5	newapprover	INSERT	DFUR Project Management	A review comment has been successfully submitted for DFUR Project record (ID: 3).	10.27.230.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-05 15:16:20.498313
565	5	newapprover	INSERT	DFUR Project Management	A review comment has been successfully submitted for DFUR Project record (ID: 69).	10.24.4.132	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-05 15:16:44.796214
566	7	approver	APPROVAL	Collection Management	Collection record approval status has been successfully updated to 'approved'.	10.27.230.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-05 15:21:11.090253
567	5	approver	INSERT	Collection Management	A review comment has been successfully submitted for Collection record (ID: 13).	10.25.60.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-05 15:21:24.792485
568	5	newapprover	INSERT	Collection Management	A review comment has been successfully submitted for Collection record (ID: 13).	10.29.69.3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-05 15:21:59.396924
569	5	approver	INSERT	Disbursement Management	A review comment has been successfully submitted for Disbursement record (ID: 6).	10.27.216.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-05 15:22:17.998099
570	5	newapprover	INSERT	Disbursement Management	A review comment has been successfully submitted for Disbursement record (ID: 6).	10.24.4.132	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-05 15:22:38.496152
571	4	treasurer	login	authentication	treasurer logged in	10.25.60.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-06 00:08:18.991153
572	4	treasurer	INSERT	Budget Management	A new budget entry has been successfully recorded in the system.	10.29.69.3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-06 00:34:41.095552
573	4	treasurer	DELETE	Budget Management	Budget entry has been successfully deleted from the system.	10.25.60.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-06 00:39:57.806431
574	4	treasurer	INSERT	Budget Management	A new budget entry has been successfully recorded in the system.	10.25.60.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-06 00:43:39.298106
575	4	treasurer	login	authentication	treasurer logged in	10.27.230.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-06 06:28:15.686032
576	4	treasurer	login	authentication	treasurer logged in	10.25.60.130	Mozilla/5.0 (Linux; Android 14; TECNO CK8nB Build/UP1A.231005.007; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/146.0.7680.164 Mobile Safari/537.36 [FB_IAB/FB4A;FBAV/555.0.0.56.66;]	2026-04-07 11:39:27.931072
577	4	treasurer	login	authentication	treasurer logged in	10.29.69.3	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-07 11:53:04.747955
578	4	treasurer	login	authentication	treasurer logged in	10.25.60.130	Mozilla/5.0 (Linux; Android 16; NDL-W09 Build/HONORNDL-W09; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/146.0.7680.166 Safari/537.36 [FB_IAB/FB4A;FBAV/555.0.0.56.66;]	2026-04-07 11:56:35.749916
579	2	kapitan	logout	authentication	kapitan logged out	10.29.69.3	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-07 12:15:52.274252
580	4	treasurer	login	authentication	treasurer logged in	10.28.88.0	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-07 12:16:43.723266
581	4	treasurer	login	authentication	treasurer logged in	10.24.4.132	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-07 12:21:51.27463
582	4	treasurer	logout	authentication	treasurer logged out	10.27.230.1	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-07 12:23:46.59276
583	5	bookkeeper	login	authentication	bookkeeper logged in	10.25.60.130	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-07 12:24:15.138112
584	4	treasurer	login	authentication	treasurer logged in	10.29.69.3	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-07 12:29:46.059265
585	4	treasurer	login	authentication	treasurer logged in	10.29.69.3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-07 23:44:48.781134
586	4	treasurer	logout	authentication	treasurer logged out	10.24.4.132	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-07 23:54:49.368735
587	7	approver	login	authentication	approver logged in	10.27.216.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-07 23:54:57.235229
588	5	approver	INSERT	Collection Management	A review comment has been successfully submitted for Collection record (ID: 16).	10.25.60.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-07 23:56:58.618619
589	5	approver	INSERT	Collection Management	A review comment has been successfully submitted for Collection record (ID: 14).	10.25.60.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-07 23:57:18.014676
590	5	approver	INSERT	Disbursement Management	A review comment has been successfully submitted for Disbursement record (ID: 4).	10.27.230.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-07 23:58:26.821011
591	5	approver	INSERT	Collection Management	A review comment has been successfully submitted for Collection record (ID: 12).	10.27.216.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-07 23:59:46.619585
592	7	approver	logout	authentication	approver logged out	10.25.60.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-08 00:00:45.290197
593	4	treasurer	login	authentication	treasurer logged in	10.27.216.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-08 00:26:07.570078
594	4	treasurer	login	authentication	treasurer logged in	10.27.216.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-08 08:27:47.178748
595	4	treasurer	login	authentication	treasurer logged in	10.25.60.130	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-09 05:16:51.462662
596	4	treasurer	login	authentication	treasurer logged in	10.27.216.0	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-09 14:42:07.46407
597	4	treasurer	logout	authentication	treasurer logged out	10.28.88.0	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-09 15:02:58.699716
598	1	superadmin	login	authentication	superadmin logged in	10.27.216.0	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-09 15:03:10.819084
599	1	superadmin	logout	authentication	superadmin logged out	10.24.4.132	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-09 15:16:35.622348
600	1	superadmin	logout	authentication	superadmin logged out	10.27.230.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-09 15:16:35.739412
601	4	treasurer	login	authentication	treasurer logged in	10.27.230.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-09 15:16:48.60146
602	4	treasurer	logout	authentication	treasurer logged out	10.28.88.0	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-09 16:33:06.836627
603	4	treasurer	login	authentication	treasurer logged in	10.29.69.3	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-09 16:33:43.920159
604	4	treasurer	login	authentication	treasurer logged in	10.25.60.130	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-10 01:36:58.875436
605	4	treasurer	logout	authentication	treasurer logged out	10.28.88.0	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-10 01:44:29.693414
606	4	treasurer	login	authentication	treasurer logged in	10.27.230.1	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-10 03:35:41.381231
607	4	treasurer	login	authentication	treasurer logged in	10.28.88.0	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-10 03:38:26.017665
608	4	treasurer	logout	authentication	treasurer logged out	10.25.60.130	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-10 03:39:12.917951
609	7	approver	login	authentication	approver logged in	10.29.69.3	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-10 03:39:19.628297
610	4	treasurer	login	authentication	treasurer logged in	10.25.60.130	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-10 03:40:23.475193
611	4	treasurer	logout	authentication	treasurer logged out	10.28.88.0	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-10 03:41:10.501636
612	7	approver	login	authentication	approver logged in	10.27.216.0	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-10 03:41:14.72889
613	7	approver	APPROVAL	Collection Management	Collection record approval status has been successfully updated to 'approved'.	10.24.4.132	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-10 03:41:42.324987
614	7	approver	logout	authentication	approver logged out	10.28.88.0	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-10 03:42:40.243004
615	6	council1	login	authentication	council1 logged in	10.28.88.0	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-10 03:43:01.091576
616	7	approver	login	authentication	approver logged in	10.25.60.130	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-10 04:10:51.312412
617	7	approver	logout	authentication	approver logged out	10.24.4.132	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-10 04:11:10.161908
618	4	treasurer	login	authentication	treasurer logged in	10.25.60.130	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-10 04:11:38.181147
619	4	treasurer	INSERT	Collection Management	A new collection record has been successfully recorded in the system.	10.27.216.0	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-10 04:12:57.919292
620	4	treasurer	INSERT	Disbursement Management	A new disbursement record has been successfully recorded in the system.	10.29.69.3	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-10 04:15:53.919506
621	4	treasurer	logout	authentication	treasurer logged out	10.29.69.3	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-10 04:16:02.220821
622	7	approver	login	authentication	approver logged in	10.28.88.0	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-10 04:16:07.695848
623	5	approver	INSERT	Disbursement Management	A review comment has been successfully submitted for Disbursement record (ID: 10).	10.24.4.132	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-10 04:16:58.226079
624	7	approver	logout	authentication	approver logged out	10.29.69.3	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-10 04:17:04.518335
625	4	treasurer	login	authentication	treasurer logged in	10.24.4.132	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-10 04:17:19.019842
626	4	treasurer	logout	authentication	treasurer logged out	10.25.60.130	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-10 04:17:37.333701
627	7	approver	login	authentication	approver logged in	10.28.88.0	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-10 04:17:41.09357
628	7	approver	logout	authentication	approver logged out	10.27.230.1	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-10 04:19:05.057919
629	4	treasurer	login	authentication	treasurer logged in	10.28.88.0	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-10 04:19:32.192748
630	4	treasurer	login	authentication	treasurer logged in	10.29.69.3	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-10 15:28:01.4938
631	4	treasurer	login	authentication	treasurer logged in	10.25.60.130	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-11 01:04:05.78762
632	4	treasurer	login	authentication	treasurer logged in	10.29.69.3	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-11 07:48:20.825425
633	4	treasurer	login	authentication	treasurer logged in	10.27.230.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-11 08:05:27.103892
634	4	treasurer	login	authentication	treasurer logged in	10.24.4.132	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-11 09:49:06.988762
635	4	treasurer	logout	authentication	treasurer logged out	10.27.230.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-11 10:23:44.425368
636	4	treasurer	login	authentication	treasurer logged in	10.27.216.0	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-11 10:31:16.26565
637	4	treasurer	login	authentication	treasurer logged in	10.25.60.130	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-11 11:23:59.665713
638	4	treasurer	login	authentication	treasurer logged in	10.29.69.3	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-11 11:52:27.466598
639	4	treasurer	login	authentication	treasurer logged in	10.29.69.3	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-11 11:59:39.765372
640	4	treasurer	login	authentication	treasurer logged in	10.28.88.0	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-11 12:51:39.963628
641	4	treasurer	UPDATE	DFUR Project Management	DFUR project record has been successfully updated.	10.27.230.1	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-11 12:59:34.824327
642	4	treasurer	INSERT	Budget Management	A new budget entry has been successfully recorded in the system.	10.29.69.3	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-11 13:03:06.417822
643	4	treasurer	logout	authentication	treasurer logged out	10.29.69.3	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-11 13:03:16.71735
644	4	treasurer	login	authentication	treasurer logged in	10.27.216.0	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-11 13:03:51.256461
645	4	treasurer	UPDATE	Budget Management	Budget entry has been successfully updated.	10.28.88.0	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-11 13:04:22.823357
646	4	treasurer	logout	authentication	treasurer logged out	10.28.88.0	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-11 13:04:31.106591
647	4	treasurer	login	authentication	treasurer logged in	10.27.216.0	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-11 13:05:40.461079
648	4	treasurer	login	authentication	treasurer logged in	10.27.230.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-11 13:57:44.500797
649	4	treasurer	logout	authentication	treasurer logged out	10.25.60.130	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-11 13:59:41.520904
650	4	treasurer	login	authentication	treasurer logged in	10.27.216.0	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-11 14:02:23.822135
651	4	treasurer	logout	authentication	treasurer logged out	10.27.216.0	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-11 14:02:56.971747
652	4	treasurer	logout	authentication	treasurer logged out	10.27.216.0	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-11 14:02:57.291885
653	4	treasurer	login	authentication	treasurer logged in	10.27.230.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-11 14:12:46.989999
654	7	approver	logout	authentication	approver logged out	10.29.69.3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-11 14:51:54.709696
655	4	treasurer	login	authentication	treasurer logged in	10.25.60.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-11 14:52:02.064245
656	4	treasurer	login	authentication	treasurer logged in	10.29.69.3	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36	2026-04-12 12:29:47.462495
657	4	treasurer	login	authentication	treasurer logged in	10.25.60.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-13 00:15:14.526152
658	4	treasurer	login	authentication	treasurer logged in	10.27.216.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0	2026-04-13 04:35:48.384703
659	4	treasurer	login	authentication	treasurer logged in	10.27.230.1	Mozilla/5.0 (Linux; Android 13; RMX3085 Build/SP1A.210812.016; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/147.0.7727.55 Mobile Safari/537.36 [FB_IAB/FB4A;FBAV/555.0.0.56.66;]	2026-04-13 05:07:15.493812
660	4	treasurer	login	authentication	treasurer logged in	10.25.60.130	Mozilla/5.0 (Linux; Android 13; RMX3085 Build/SP1A.210812.016; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/147.0.7727.55 Mobile Safari/537.36 [FB_IAB/FB4A;FBAV/555.0.0.56.66;]	2026-04-13 05:12:35.985206
661	4	treasurer	logout	authentication	treasurer logged out	10.27.230.1	Mozilla/5.0 (Linux; Android 13; RMX3085 Build/SP1A.210812.016; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/147.0.7727.55 Mobile Safari/537.36 [FB_IAB/FB4A;FBAV/555.0.0.56.66;]	2026-04-13 05:13:33.799036
662	2	kapitan	login	authentication	kapitan logged in	10.28.88.0	Mozilla/5.0 (Linux; Android 13; RMX3085 Build/SP1A.210812.016; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/147.0.7727.55 Mobile Safari/537.36 [FB_IAB/FB4A;FBAV/555.0.0.56.66;]	2026-04-13 05:13:45.983217
663	2	kapitan	logout	authentication	kapitan logged out	10.27.216.0	Mozilla/5.0 (Linux; Android 13; RMX3085 Build/SP1A.210812.016; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/147.0.7727.55 Mobile Safari/537.36 [FB_IAB/FB4A;FBAV/555.0.0.56.66;]	2026-04-13 05:14:17.353167
664	5	bookkeeper	login	authentication	bookkeeper logged in	10.28.88.0	Mozilla/5.0 (Linux; Android 13; RMX3085 Build/SP1A.210812.016; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/147.0.7727.55 Mobile Safari/537.36 [FB_IAB/FB4A;FBAV/555.0.0.56.66;]	2026-04-13 05:14:29.259524
665	5	bookkeeper	logout	authentication	bookkeeper logged out	10.29.69.3	Mozilla/5.0 (Linux; Android 13; RMX3085 Build/SP1A.210812.016; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/147.0.7727.55 Mobile Safari/537.36 [FB_IAB/FB4A;FBAV/555.0.0.56.66;]	2026-04-13 05:27:13.413243
666	4	treasurer	login	authentication	treasurer logged in	10.29.69.3	Mozilla/5.0 (Linux; Android 13; RMX3085 Build/SP1A.210812.016; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/147.0.7727.55 Mobile Safari/537.36 [FB_IAB/FB4A;FBAV/555.0.0.56.66;]	2026-04-13 05:27:54.360642
667	4	treasurer	login	authentication	treasurer logged in	10.25.60.130	Mozilla/5.0 (Linux; Android 13; RMX3085 Build/SP1A.210812.016; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/147.0.7727.55 Mobile Safari/537.36 [FB_IAB/FB4A;FBAV/555.0.0.56.66;]	2026-04-13 08:01:36.412823
668	5	bookkeeper	login	authentication	bookkeeper logged in	10.28.88.0	Mozilla/5.0 (Linux; Android 13; RMX3085 Build/SP1A.210812.016; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/147.0.7727.55 Mobile Safari/537.36 [FB_IAB/FB4A;FBAV/555.0.0.56.66;]	2026-04-13 08:04:39.573411
669	5	bookkeeper	logout	authentication	bookkeeper logged out	10.27.230.1	Mozilla/5.0 (Linux; Android 13; RMX3085 Build/SP1A.210812.016; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/147.0.7727.55 Mobile Safari/537.36 [FB_IAB/FB4A;FBAV/555.0.0.56.66;]	2026-04-13 08:08:02.712143
670	2	kapitan	login	authentication	kapitan logged in	10.27.216.0	Mozilla/5.0 (Linux; Android 13; RMX3085 Build/SP1A.210812.016; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/147.0.7727.55 Mobile Safari/537.36 [FB_IAB/FB4A;FBAV/555.0.0.56.66;]	2026-04-13 08:08:19.282006
671	4	treasurer	login	authentication	treasurer logged in	10.27.230.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-13 08:10:12.713935
672	4	treasurer	login	authentication	treasurer logged in	10.27.216.0	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-13 09:48:13.312707
673	4	treasurer	login	authentication	treasurer logged in	10.25.60.130	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-13 14:36:46.061969
674	4	treasurer	logout	authentication	treasurer logged out	10.25.60.130	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-13 16:05:51.546395
675	4	treasurer	login	authentication	treasurer logged in	10.27.230.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-04-13 16:27:51.19932
676	4	treasurer	login	authentication	treasurer logged in	10.27.216.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-14 08:55:18.765339
677	4	treasurer	logout	authentication	treasurer logged out	10.29.69.3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-14 09:02:36.249797
678	4	treasurer	login	authentication	treasurer logged in	10.29.69.3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-14 09:27:45.200586
679	4	treasurer	login	authentication	treasurer logged in	10.27.230.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-14 14:33:37.65633
680	4	treasurer	login	authentication	treasurer logged in	10.25.60.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-14 15:00:09.761133
681	4	treasurer	INSERT	Collection Management	A new collection record has been successfully recorded in the system.	10.24.4.132	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-14 15:06:48.81698
682	4	treasurer	INSERT	Disbursement Management	A new disbursement record has been successfully recorded in the system.	10.28.88.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-14 15:19:42.920826
683	4	treasurer	login	authentication	treasurer logged in	10.25.60.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-15 01:39:01.964847
684	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	127.0.0.1	PostmanRuntime/7.53.0	2026-04-15 01:42:12.889083
685	4	treasurer	INSERT_FAILED	Disbursement Management	Disbursement record creation failed. The operation could not be completed. Please try again or contact the system administrator.	127.0.0.1	PostmanRuntime/7.53.0	2026-04-15 01:55:22.70536
686	4	treasurer	INSERT	Disbursement Management	A new disbursement record has been successfully recorded in the system.	127.0.0.1	PostmanRuntime/7.53.0	2026-04-15 02:00:00.721848
687	4	treasurer	UPDATE	Disbursement Management	Disbursement record has been successfully updated.	127.0.0.1	PostmanRuntime/7.53.0	2026-04-15 02:12:49.237822
688	4	treasurer	UPDATE	Disbursement Management	Disbursement record has been successfully updated.	127.0.0.1	PostmanRuntime/7.53.0	2026-04-15 02:13:34.210124
689	4	treasurer	UPDATE	Disbursement Management	Disbursement record has been successfully updated.	127.0.0.1	PostmanRuntime/7.53.0	2026-04-15 02:17:00.057689
690	4	treasurer	UPDATE	Disbursement Management	Disbursement record has been successfully updated.	127.0.0.1	PostmanRuntime/7.53.0	2026-04-15 02:18:43.286876
691	4	treasurer	UPDATE	Disbursement Management	Disbursement record has been successfully updated.	127.0.0.1	PostmanRuntime/7.53.0	2026-04-15 02:19:35.713406
692	4	treasurer	login	authentication	treasurer logged in	10.29.69.3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-15 06:18:24.661411
693	1	superadmin	login	authentication	superadmin logged in	10.27.216.0	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36	2026-04-15 06:19:49.46586
694	1	superadmin	logout	authentication	superadmin logged out	10.25.60.130	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36	2026-04-15 06:20:38.227117
695	4	treasurer	login	authentication	treasurer logged in	10.27.216.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-15 07:35:08.1275
696	4	treasurer	logout	authentication	treasurer logged out	10.24.4.132	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-15 07:40:54.64323
697	4	treasurer	login	authentication	treasurer logged in	10.24.4.132	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-15 07:42:10.401622
698	4	treasurer	logout	authentication	treasurer logged out	10.24.4.132	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-15 07:43:53.504379
699	4	treasurer	login	authentication	treasurer logged in	10.24.4.132	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-15 07:53:29.644355
700	4	treasurer	UPDATE	Disbursement Management	Disbursement record has been successfully updated.	10.29.69.3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-15 13:24:56.220867
701	4	treasurer	UPDATE	Disbursement Management	Disbursement record has been successfully updated.	10.28.88.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-15 13:36:25.817242
702	4	treasurer	UPDATE	Disbursement Management	Disbursement record has been successfully updated.	10.25.60.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-15 13:36:43.317743
703	4	treasurer	INSERT	Disbursement Management	A new disbursement record has been successfully recorded in the system.	10.25.60.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-15 13:51:34.617591
704	5	bookkeeper	login	authentication	bookkeeper logged in	10.27.230.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-15 23:24:32.716789
705	5	bookkeeper	logout	authentication	bookkeeper logged out	10.29.69.3	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-15 23:24:51.520494
706	4	treasurer	login	authentication	treasurer logged in	10.24.4.132	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-15 23:25:21.342613
707	4	treasurer	login	authentication	treasurer logged in	10.27.230.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-15 23:29:15.408876
708	4	treasurer	INSERT	Budget Management	A new budget entry has been successfully recorded in the system.	10.29.69.3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-16 00:34:22.921187
709	4	treasurer	UPDATE	Budget Management	Budget entry has been successfully updated.	10.27.216.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-16 00:47:16.619414
710	4	treasurer	login	authentication	treasurer logged in	10.29.69.3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-16 04:50:50.717067
711	4	treasurer	login	authentication	treasurer logged in	10.27.230.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-16 06:05:15.292819
712	4	treasurer	UPDATE	Disbursement Management	Disbursement record has been successfully updated.	10.25.60.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-16 06:18:01.019707
713	4	treasurer	UPDATE	Disbursement Management	Disbursement record has been successfully updated.	10.27.216.0	PostmanRuntime/7.53.0	2026-04-16 06:31:33.92291
714	4	treasurer	logout	authentication	treasurer logged out	10.24.4.132	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-16 06:45:43.049826
715	4	treasurer	login	authentication	treasurer logged in	10.28.88.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-16 07:44:36.38979
716	4	treasurer	logout	authentication	treasurer logged out	10.27.230.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-16 15:39:31.561869
717	4	treasurer	login	authentication	treasurer logged in	10.27.230.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-16 15:44:33.605548
718	4	treasurer	INSERT	Budget Management	A new budget entry has been successfully recorded in the system.	10.29.69.3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-16 15:52:21.818638
719	4	treasurer	DELETE	Budget Management	Budget entry has been successfully deleted from the system.	10.25.60.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-16 15:52:56.121162
720	4	treasurer	INSERT	Budget Management	A new budget entry has been successfully recorded in the system.	10.29.69.3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-16 15:58:22.319048
721	4	treasurer	INSERT	Budget Management	A new budget entry has been successfully recorded in the system.	10.29.69.3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-16 16:06:20.32222
722	4	treasurer	DELETE	Budget Management	Budget entry has been successfully deleted from the system.	10.24.4.132	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-16 16:11:13.613715
723	4	treasurer	DELETE	Budget Management	Budget entry has been successfully deleted from the system.	10.28.88.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-16 16:11:18.819797
724	4	treasurer	INSERT	Budget Management	A new budget entry has been successfully recorded in the system.	10.27.230.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-16 16:11:39.916951
725	4	treasurer	DELETE	Budget Management	Budget entry has been successfully deleted from the system.	10.27.216.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-16 16:14:21.921811
726	4	treasurer	INSERT	Budget Management	A new budget entry has been successfully recorded in the system.	10.28.88.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-16 16:14:43.32152
727	4	treasurer	UPDATE	Budget Management	Budget entry has been successfully updated.	10.24.4.132	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-16 16:16:03.526793
728	4	treasurer	login	authentication	treasurer logged in	10.28.88.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-18 13:35:58.710507
729	4	treasurer	login	authentication	treasurer logged in	10.25.60.130	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-18 14:07:38.107955
730	4	treasurer	logout	authentication	treasurer logged out	10.28.88.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-18 14:13:21.013376
731	4	treasurer	login	authentication	treasurer logged in	10.29.69.3	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-19 03:50:00.738776
732	4	treasurer	logout	authentication	treasurer logged out	10.28.88.0	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-19 03:50:14.690665
733	4	treasurer	login	authentication	treasurer logged in	10.24.4.132	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36	2026-04-19 03:50:41.413736
734	4	treasurer	login	authentication	treasurer logged in	10.25.60.130	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-19 03:50:51.322079
735	4	treasurer	INSERT	Disbursement Management	A new disbursement record has been successfully recorded in the system.	10.28.88.0	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-19 03:56:05.416671
736	4	treasurer	logout	authentication	treasurer logged out	10.25.60.130	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36	2026-04-19 03:58:26.552628
737	4	treasurer	DELETE	Disbursement Management	Disbursement record has been successfully deleted from the system.	10.29.69.3	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-19 03:59:21.12059
738	4	treasurer	UPDATE	DFUR Project Management	DFUR project record has been successfully updated.	10.28.88.0	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-19 04:00:23.514777
739	4	treasurer	logout	authentication	treasurer logged out	10.29.69.3	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-19 04:00:56.534517
740	1	superadmin	login	authentication	superadmin logged in	10.28.88.0	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-19 04:01:23.301538
741	1	superadmin	logout	authentication	superadmin logged out	10.28.88.0	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-04-19 04:05:48.390946
742	4	treasurer	login	authentication	treasurer logged in	10.27.230.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-19 04:24:01.508334
743	7	approver	login	authentication	approver logged in	10.27.216.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2026-04-19 06:35:14.307072
744	7	approver	APPROVAL	Collection Management	Collection record approval status has been successfully updated to 'approved'.	10.27.216.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2026-04-19 06:36:17.921352
745	7	approver	logout	authentication	approver logged out	10.28.88.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2026-04-19 06:39:29.426595
746	4	treasurer	login	authentication	treasurer logged in	10.28.88.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2026-04-19 06:40:54.60314
747	4	treasurer	login	authentication	treasurer logged in	10.29.69.3	Mozilla/5.0 (Linux; Android 16; NDL-W09 Build/HONORNDL-W09; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/146.0.7680.177 Safari/537.36 [FB_IAB/FB4A;FBAV/557.0.0.53.76;]	2026-04-19 06:45:55.896575
748	4	treasurer	logout	authentication	treasurer logged out	10.29.69.3	Mozilla/5.0 (Linux; Android 16; NDL-W09 Build/HONORNDL-W09; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/146.0.7680.177 Safari/537.36 [FB_IAB/FB4A;FBAV/557.0.0.53.76;]	2026-04-19 06:47:23.816059
749	4	treasurer	logout	authentication	treasurer logged out	10.25.60.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2026-04-19 06:48:00.359553
750	4	treasurer	login	authentication	treasurer logged in	10.24.4.132	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2026-04-19 06:56:28.315006
751	4	treasurer	login	authentication	treasurer logged in	10.28.88.0	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-04-19 06:56:59.201258
752	4	treasurer	INSERT	Collection Management	A new collection record has been successfully recorded in the system.	10.24.4.132	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2026-04-19 06:58:06.518335
753	4	treasurer	logout	authentication	treasurer logged out	10.29.69.3	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-04-19 07:03:42.002613
754	11	checker	login	authentication	checker logged in	10.28.88.0	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-04-19 07:03:58.703746
755	4	treasurer	logout	authentication	treasurer logged out	10.27.216.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2026-04-19 07:04:55.119946
756	4	treasurer	login	authentication	treasurer logged in	10.24.4.132	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2026-04-19 07:06:19.212731
757	4	treasurer	INSERT	Collection Management	A new collection record has been successfully recorded in the system.	10.24.4.132	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2026-04-19 07:07:14.618156
758	4	treasurer	logout	authentication	treasurer logged out	10.25.60.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2026-04-19 07:07:30.016865
759	11	checker	logout	authentication	checker logged out	10.24.4.132	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-04-19 07:07:38.892195
760	4	treasurer	login	authentication	treasurer logged in	10.27.216.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2026-04-19 07:09:49.104077
761	4	treasurer	INSERT	DFUR Project Management	A new DFUR project record has been successfully recorded in the system.	10.27.230.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2026-04-19 07:12:34.217821
762	4	treasurer	logout	authentication	treasurer logged out	10.29.69.3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2026-04-19 07:12:44.505974
763	7	approver	login	authentication	approver logged in	10.27.216.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2026-04-19 07:13:43.742265
764	7	approver	logout	authentication	approver logged out	10.25.60.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2026-04-19 07:14:00.063572
765	4	treasurer	login	authentication	treasurer logged in	10.24.4.132	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2026-04-19 07:16:37.548515
766	4	treasurer	logout	authentication	treasurer logged out	10.27.216.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2026-04-19 07:17:37.924164
767	4	treasurer	login	authentication	treasurer logged in	10.24.4.132	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2026-04-19 07:17:59.049521
768	4	treasurer	login	authentication	treasurer logged in	10.27.230.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-04-19 07:18:09.203725
769	4	treasurer	logout	authentication	treasurer logged out	10.29.69.3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2026-04-19 07:19:06.671528
770	4	treasurer	login	authentication	treasurer logged in	10.25.60.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2026-04-19 07:23:31.896427
771	4	treasurer	logout	authentication	treasurer logged out	10.25.60.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2026-04-19 07:26:52.923154
772	4	treasurer	logout	authentication	treasurer logged out	10.27.216.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2026-04-19 07:26:53.212236
773	4	treasurer	logout	authentication	treasurer logged out	10.27.230.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2026-04-19 07:26:53.312135
774	7	approver	login	authentication	approver logged in	10.25.60.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2026-04-19 07:28:13.116526
775	4	treasurer	login	authentication	treasurer logged in	10.28.88.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2026-04-19 07:32:49.814856
776	4	treasurer	logout	authentication	treasurer logged out	10.29.69.3	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-04-19 07:37:08.201235
777	4	treasurer	login	authentication	treasurer logged in	10.28.88.0	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-04-19 07:37:30.796719
778	4	treasurer	login	authentication	treasurer logged in	10.25.60.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2026-04-19 07:43:10.347295
779	4	treasurer	INSERT	Disbursement Management	A new disbursement record has been successfully recorded in the system.	10.24.4.132	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-04-19 07:43:45.317255
780	4	treasurer	login	authentication	treasurer logged in	10.29.69.3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2026-04-19 07:45:32.830924
781	4	treasurer	INSERT	Budget Management	A new budget entry has been successfully recorded in the system.	10.29.69.3	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-04-19 07:46:07.014657
782	4	treasurer	logout	authentication	treasurer logged out	10.24.4.132	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2026-04-19 07:47:17.524
783	4	treasurer	logout	authentication	treasurer logged out	10.25.60.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2026-04-19 07:47:17.621131
784	4	treasurer	logout	authentication	treasurer logged out	10.24.4.132	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2026-04-19 07:47:17.952291
785	4	treasurer	logout	authentication	treasurer logged out	10.25.60.130	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-04-19 07:47:52.079982
786	11	checker	login	authentication	checker logged in	10.25.60.130	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-04-19 07:48:05.317464
787	6	council1	login	authentication	council1 logged in	10.28.88.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2026-04-19 07:48:23.307579
788	6	council1	logout	authentication	council1 logged out	10.27.216.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2026-04-19 07:49:59.308176
789	6	council1	logout	authentication	council1 logged out	10.27.230.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2026-04-19 07:49:59.604965
790	6	council1	logout	authentication	council1 logged out	10.28.88.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2026-04-19 07:49:59.641444
791	6	council1	logout	authentication	council1 logged out	10.27.230.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2026-04-19 07:49:59.717497
792	6	council1	logout	authentication	council1 logged out	10.29.69.3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2026-04-19 07:49:59.819019
793	7	approver	login	authentication	approver logged in	10.27.216.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2026-04-19 07:50:00.734899
794	7	approver	APPROVAL	DFUR Project Management	DFUR project record approval status has been successfully updated to 'approved'.	10.27.230.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2026-04-19 07:50:46.420541
795	7	approver	logout	authentication	approver logged out	10.27.230.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2026-04-19 07:52:49.729608
796	7	approver	login	authentication	approver logged in	10.27.216.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2026-04-19 07:53:02.548553
797	7	approver	logout	authentication	approver logged out	10.28.88.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2026-04-19 07:54:11.399795
798	7	approver	login	authentication	approver logged in	10.29.69.3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2026-04-19 07:54:48.333928
799	7	approver	logout	authentication	approver logged out	10.28.88.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2026-04-19 07:57:27.061954
800	11	checker	login	authentication	checker logged in	10.28.88.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2026-04-19 07:58:04.399966
801	11	checker	logout	authentication	checker logged out	10.25.60.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2026-04-19 07:58:35.278376
802	1	superadmin	login	authentication	superadmin logged in	10.29.69.3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	2026-04-19 07:59:39.946387
803	4	treasurer	login	authentication	treasurer logged in	10.195.192.4	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-19 13:03:55.619463
804	4	treasurer	INSERT	Collection Management	A new collection record has been successfully recorded in the system.	10.27.216.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-19 13:04:22.318076
805	4	treasurer	logout	authentication	treasurer logged out	10.27.216.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-19 13:04:27.388787
806	4	treasurer	login	authentication	treasurer logged in	10.27.230.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-19 13:05:01.90195
807	4	treasurer	INSERT	Disbursement Management	A new disbursement record has been successfully recorded in the system.	10.27.216.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-19 13:05:45.417655
808	4	treasurer	logout	authentication	treasurer logged out	10.25.60.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-19 13:05:55.371721
809	4	treasurer	login	authentication	treasurer logged in	10.29.69.3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-19 13:06:42.81792
810	4	treasurer	logout	authentication	treasurer logged out	10.27.230.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-19 13:07:04.643952
811	6	council1	login	authentication	council1 logged in	10.27.216.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-19 13:20:26.807586
812	6	council1	logout	authentication	council1 logged out	10.24.4.132	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-19 13:20:42.716554
813	4	treasurer	login	authentication	treasurer logged in	10.27.230.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-19 13:22:17.203953
814	4	treasurer	logout	authentication	treasurer logged out	10.25.60.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-19 13:23:49.336053
815	7	approver	login	authentication	approver logged in	10.24.4.132	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-19 13:23:58.738253
816	7	approver	logout	authentication	approver logged out	10.24.4.132	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-19 13:25:20.916499
817	4	treasurer	login	authentication	treasurer logged in	10.27.216.0	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-04-20 13:28:39.805546
818	4	treasurer	login	authentication	treasurer logged in	10.27.216.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-21 01:55:30.014045
819	4	treasurer	logout	authentication	treasurer logged out	10.25.60.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-21 06:05:03.304299
820	4	treasurer	login	authentication	treasurer logged in	10.24.4.132	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-21 15:10:19.793355
821	4	treasurer	UPDATE	DFUR Project Management	DFUR project record has been successfully updated.	10.25.60.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-21 15:16:11.717161
822	4	treasurer	INSERT	Budget Management	A new budget entry has been successfully recorded in the system.	10.28.88.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-21 15:32:12.319313
823	4	treasurer	DELETE	Budget Management	Budget entry has been successfully deleted from the system.	10.28.88.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-21 15:35:22.421854
824	4	treasurer	INSERT	Budget Management	A new budget entry has been successfully recorded in the system.	10.27.230.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-21 15:35:42.618364
825	4	treasurer	logout	authentication	treasurer logged out	10.28.88.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-21 15:38:57.237483
826	7	approver	login	authentication	approver logged in	10.29.69.3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-21 15:39:04.598634
827	4	treasurer	login	authentication	treasurer logged in	10.29.69.3	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-25 05:49:42.13956
828	4	treasurer	logout	authentication	treasurer logged out	10.27.230.1	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-25 06:00:52.955559
829	1	superadmin	login	authentication	superadmin logged in	10.27.230.1	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-25 06:01:45.01508
830	1	superadmin	login	authentication	superadmin logged in	10.29.69.3	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-25 06:02:06.956585
831	1	superadmin	logout	authentication	superadmin logged out	10.27.230.1	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-25 06:10:53.947723
832	7	approver	login	authentication	approver logged in	10.29.69.3	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-25 06:10:57.90654
833	7	approver	logout	authentication	approver logged out	10.27.216.0	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-25 06:11:07.034411
834	4	treasurer	login	authentication	treasurer logged in	10.27.216.0	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-25 06:11:22.912945
835	4	treasurer	login	authentication	treasurer logged in	10.27.230.1	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-25 06:21:24.598326
836	4	treasurer	INSERT	Collection Management	A new collection record has been successfully recorded in the system.	10.25.60.130	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-25 06:22:50.013773
837	4	treasurer	INSERT	Disbursement Management	A new disbursement record has been successfully recorded in the system.	10.27.216.0	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-04-25 06:28:53.014104
838	4	treasurer	UPDATE	Disbursement Management	Disbursement record has been successfully updated.	10.24.4.132	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-25 06:29:37.218902
839	4	treasurer	logout	authentication	treasurer logged out	10.28.88.0	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-04-25 06:32:24.230283
840	5	bookkeeper	login	authentication	bookkeeper logged in	10.29.69.3	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-04-25 06:32:48.303091
841	7	approver	login	authentication	approver logged in	10.28.88.0	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-25 06:36:20.138504
842	7	approver	logout	authentication	approver logged out	10.27.216.0	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-04-25 06:39:20.620496
843	6	council1	login	authentication	council1 logged in	10.27.216.0	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-04-25 06:40:58.738717
844	6	council1	logout	authentication	council1 logged out	10.27.216.0	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-04-25 06:41:12.161936
845	6	council1	login	authentication	council1 logged in	10.27.230.1	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-25 06:41:38.677333
846	6	council1	login	authentication	council1 logged in	10.24.4.132	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-25 06:42:07.100291
847	6	council1	login	authentication	council1 logged in	10.28.88.0	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-25 06:42:27.244162
848	7	approver	logout	authentication	approver logged out	10.27.230.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-25 07:50:26.539295
849	5	bookkeeper	login	authentication	bookkeeper logged in	10.27.216.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-25 08:05:53.245608
850	5	bookkeeper	logout	authentication	bookkeeper logged out	10.27.230.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-25 08:08:49.083253
851	6	council1	login	authentication	council1 logged in	10.27.230.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-25 08:09:14.009606
852	6	council1	logout	authentication	council1 logged out	10.25.60.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-25 08:09:17.343418
853	6	council1	login	authentication	council1 logged in	10.27.230.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-25 08:09:42.39828
854	6	council1	logout	authentication	council1 logged out	10.25.60.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-25 08:11:05.997255
855	4	treasurer	login	authentication	treasurer logged in	10.29.69.3	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-25 08:13:58.703583
856	1	superadmin	login	authentication	superadmin logged in	10.27.216.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-25 08:15:05.307857
857	1	superadmin	login	authentication	superadmin logged in	10.27.230.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-25 08:15:33.092456
858	4	treasurer	login	authentication	treasurer logged in	10.27.230.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-26 14:48:31.401921
859	4	treasurer	DELETE_FAILED	DFUR Project Management	DFUR project record deletion failed. Please verify the record ID and try again.	10.28.88.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-26 14:57:40.817983
860	4	treasurer	DELETE_FAILED	DFUR Project Management	DFUR project record deletion failed. Please verify the record ID and try again.	10.27.230.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-26 14:57:48.318243
861	4	treasurer	DELETE_FAILED	DFUR Project Management	DFUR project record deletion failed. Please verify the record ID and try again.	10.27.216.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-26 14:58:12.317804
862	4	treasurer	INSERT	DFUR Project Management	A new DFUR project record has been successfully recorded in the system.	10.25.60.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-26 14:58:43.118786
863	4	treasurer	DELETE	DFUR Project Management	DFUR project record has been successfully deleted from the system.	10.29.69.3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-26 14:58:50.618756
864	4	treasurer	DELETE	DFUR Project Management	DFUR project record has been successfully deleted from the system.	10.28.88.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-26 14:58:58.917322
865	4	treasurer	DELETE_FAILED	DFUR Project Management	DFUR project record deletion failed. Please verify the record ID and try again.	10.29.69.3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-26 14:59:03.416968
866	4	treasurer	DELETE_FAILED	DFUR Project Management	DFUR project record deletion failed. Please verify the record ID and try again.	10.27.230.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-26 14:59:06.917384
867	4	treasurer	INSERT	DFUR Project Management	A new DFUR project record has been successfully recorded in the system.	10.27.230.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-26 14:59:40.614442
868	4	treasurer	UPDATE	DFUR Project Management	DFUR project record has been successfully updated.	10.24.4.132	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-26 15:00:17.216879
869	4	treasurer	DELETE_FAILED	DFUR Project Management	DFUR project record deletion failed. Please verify the record ID and try again.	10.29.69.3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-26 15:00:27.112139
870	4	treasurer	login	authentication	treasurer logged in	10.28.88.0	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-04-27 11:17:20.449806
871	4	treasurer	logout	authentication	treasurer logged out	10.29.69.3	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-04-27 11:18:42.159695
872	7	approver	login	authentication	approver logged in	10.28.88.0	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-04-27 11:30:21.301505
873	4	treasurer	login	authentication	treasurer logged in	10.29.69.3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-27 15:13:27.406646
874	4	treasurer	login	authentication	treasurer logged in	10.27.216.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-27 15:14:09.401979
875	4	treasurer	login	authentication	treasurer logged in	10.29.69.3	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-04-27 17:25:44.739338
876	4	treasurer	UPDATE	Disbursement Management	Disbursement record has been successfully updated.	10.25.60.130	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-04-27 17:26:25.814636
877	4	treasurer	logout	authentication	treasurer logged out	10.29.69.3	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-04-27 17:26:40.558845
878	4	treasurer	login	authentication	treasurer logged in	10.29.69.3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 04:06:19.445326
879	4	treasurer	login	authentication	treasurer logged in	10.29.69.3	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36	2026-04-28 04:12:42.816353
880	4	treasurer	logout	authentication	treasurer logged out	10.28.88.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 04:36:59.06067
881	7	approver	login	authentication	approver logged in	10.27.230.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 04:37:52.913
882	7	approver	logout	authentication	approver logged out	10.27.216.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 04:40:00.736254
883	7	approver	login	authentication	approver logged in	10.25.60.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 04:47:07.134329
884	7	approver	logout	authentication	approver logged out	10.25.60.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 04:47:16.374562
885	5	bookkeeper	login	authentication	bookkeeper logged in	10.29.69.3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 04:47:26.04711
886	5	bookkeeper	logout	authentication	bookkeeper logged out	10.25.60.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 04:49:21.39511
887	4	treasurer	login	authentication	treasurer logged in	10.29.69.3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 04:49:38.893324
888	4	treasurer	logout	authentication	treasurer logged out	10.29.69.3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 04:53:45.119751
889	4	treasurer	logout	authentication	treasurer logged out	10.29.69.3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 04:53:46.16861
890	4	treasurer	login	authentication	treasurer logged in	10.24.4.132	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 05:05:26.801382
891	4	treasurer	logout	authentication	treasurer logged out	10.27.216.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 05:11:37.309542
892	4	treasurer	login	authentication	treasurer logged in	10.29.69.3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 05:15:25.516324
893	4	treasurer	INSERT	Collection Management	A new collection record has been successfully recorded in the system.	10.24.4.132	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 05:16:40.417081
894	4	treasurer	INSERT	Collection Management	A new collection record has been successfully recorded in the system.	10.27.216.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 05:17:07.61843
895	4	treasurer	logout	authentication	treasurer logged out	10.24.4.132	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 05:17:17.872648
896	4	treasurer	login	authentication	treasurer logged in	10.27.230.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 05:36:13.411359
897	4	treasurer	logout	authentication	treasurer logged out	10.27.230.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 05:36:40.002041
898	4	treasurer	login	authentication	treasurer logged in	10.24.4.132	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 05:45:15.628076
899	4	treasurer	logout	authentication	treasurer logged out	10.24.4.132	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 05:45:51.490149
900	4	treasurer	login	authentication	treasurer logged in	10.27.230.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 06:00:32.199577
901	4	treasurer	login	authentication	treasurer logged in	10.27.230.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 06:01:00.746079
902	4	treasurer	INSERT	Budget Management	A new budget entry has been successfully recorded in the system.	10.24.4.132	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 06:04:32.61786
903	4	treasurer	login	authentication	treasurer logged in	10.29.69.3	Mozilla/5.0 (Linux; Android 13; RMX3085 Build/SP1A.210812.016; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/147.0.7727.55 Mobile Safari/537.36 [FB_IAB/FB4A;FBAV/558.0.0.46.77;]	2026-04-28 06:05:14.99998
904	4	treasurer	INSERT_FAILED	Budget Management	Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.29.69.3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 06:10:05.318017
905	4	treasurer	login	authentication	treasurer logged in	10.29.69.3	Mozilla/5.0 (Linux; Android 13; RMX3085 Build/SP1A.210812.016; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/147.0.7727.55 Mobile Safari/537.36 [FB_IAB/FB4A;FBAV/558.0.0.46.77;]	2026-04-28 06:10:11.696737
906	4	treasurer	INSERT_FAILED	Budget Management	Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.28.88.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 06:10:27.017285
907	4	treasurer	INSERT_FAILED	Budget Management	Budget entry creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.28.88.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 06:12:08.317584
908	4	treasurer	INSERT	Budget Management	A new budget entry has been successfully recorded in the system.	10.25.60.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 06:12:36.014243
909	4	treasurer	DELETE	Budget Management	Budget entry has been successfully deleted from the system.	10.29.69.3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 06:13:43.118034
1006	4	treasurer	login	authentication	treasurer logged in	10.28.88.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-29 14:56:01.836018
910	4	treasurer	logout	authentication	treasurer logged out	10.27.216.0	Mozilla/5.0 (Linux; Android 13; RMX3085 Build/SP1A.210812.016; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/147.0.7727.55 Mobile Safari/537.36 [FB_IAB/FB4A;FBAV/558.0.0.46.77;]	2026-04-28 06:14:00.285836
911	4	treasurer	login	authentication	treasurer logged in	10.25.60.130	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 [FBAN/FBIOS;FBAV/558.2.0.42.110;FBBV/952277649;FBDV/iPhone11,8;FBMD/iPhone;FBSN/iOS;FBSV/18.7.7;FBSS/2;FBCR/;FBID/phone;FBLC/en_US;FBOP/80]	2026-04-28 06:21:03.194002
912	4	treasurer	login	authentication	treasurer logged in	10.27.230.1	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36	2026-04-28 06:22:32.816669
913	4	treasurer	login	authentication	treasurer logged in	10.24.4.132	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 06:25:31.289298
914	4	treasurer	DELETE	Budget Management	Budget entry has been successfully deleted from the system.	10.27.216.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 06:26:02.915199
915	4	treasurer	DELETE	Budget Management	Budget entry has been successfully deleted from the system.	10.27.216.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 06:26:09.513217
916	5	bookkeeper	login	authentication	bookkeeper logged in	10.27.216.0	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 06:27:20.413337
917	5	bookkeeper	logout	authentication	bookkeeper logged out	10.28.88.0	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36	2026-04-28 06:31:07.952007
918	2	kapitan	login	authentication	kapitan logged in	10.24.4.132	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36	2026-04-28 06:31:17.801169
919	4	treasurer	logout	authentication	treasurer logged out	10.25.60.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 06:33:31.854624
920	4	treasurer	login	authentication	treasurer logged in	10.24.4.132	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-28 06:33:40.247701
921	4	treasurer	login	authentication	treasurer logged in	10.28.88.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 06:33:56.002295
922	3	secretary	login	authentication	secretary logged in	10.27.216.0	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36	2026-04-28 06:34:42.813403
923	4	treasurer	logout	authentication	treasurer logged out	10.27.216.0	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-28 06:35:12.895912
924	6	council1	login	authentication	council1 logged in	10.27.216.0	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36	2026-04-28 06:37:20.399844
925	4	treasurer	logout	authentication	treasurer logged out	10.27.230.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 06:38:15.798253
926	6	council1	logout	authentication	council1 logged out	10.27.230.1	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36	2026-04-28 06:38:30.314368
927	7	approver	login	authentication	approver logged in	10.27.216.0	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36	2026-04-28 06:39:55.137555
928	7	approver	logout	authentication	approver logged out	10.24.4.132	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36	2026-04-28 06:43:07.759303
929	1	superadmin	login	authentication	superadmin logged in	10.28.88.0	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36	2026-04-28 06:43:56.743966
930	4	treasurer	login	authentication	treasurer logged in	10.25.60.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 07:14:41.808152
931	4	treasurer	DELETE	Collection Management	Collection record has been successfully deleted from the system.	10.27.230.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 07:15:39.214231
932	4	treasurer	DELETE	Collection Management	Collection record has been successfully deleted from the system.	10.24.4.132	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 07:15:53.517518
933	4	treasurer	login	authentication	treasurer logged in	10.25.60.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 07:46:39.739431
934	5	bookkeeper	login	authentication	bookkeeper logged in	10.27.230.1	Mozilla/5.0 (Linux; Android 13; RMX3085 Build/SP1A.210812.016; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/147.0.7727.55 Mobile Safari/537.36 [FB_IAB/FB4A;FBAV/558.0.0.46.77;]	2026-04-28 07:57:54.397556
935	4	treasurer	login	authentication	treasurer logged in	10.27.230.1	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-28 09:18:00.805328
936	1	superadmin	login	authentication	superadmin logged in	10.24.4.132	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-28 10:03:46.103215
937	4	treasurer	logout	authentication	treasurer logged out	10.27.216.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 10:21:28.923382
938	4	treasurer	login	authentication	treasurer logged in	10.27.216.0	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-28 10:21:41.598842
939	6	council1	login	authentication	council1 logged in	10.27.216.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 10:21:52.212319
940	4	treasurer	UPDATE	Budget Management	Budget entry has been successfully updated.	10.27.216.0	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-28 10:22:18.618339
941	4	treasurer	logout	authentication	treasurer logged out	10.27.216.0	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-28 10:22:25.992842
942	1	superadmin	login	authentication	superadmin logged in	10.27.216.0	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-28 10:22:49.10072
943	6	council1	login	authentication	council1 logged in	10.24.4.132	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36	2026-04-28 10:32:10.702904
944	6	council1	login	authentication	council1 logged in	10.28.88.0	Mozilla/5.0 (Linux; Android 13; RMX3085 Build/SP1A.210812.016; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/147.0.7727.55 Mobile Safari/537.36 [FB_IAB/FB4A;FBAV/558.0.0.46.77;]	2026-04-28 10:36:26.202543
945	6	council1	logout	authentication	council1 logged out	10.29.69.3	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36	2026-04-28 10:37:01.457206
946	5	bookkeeper	login	authentication	bookkeeper logged in	10.24.4.132	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36	2026-04-28 10:37:31.44626
947	5	bookkeeper	logout	authentication	bookkeeper logged out	10.29.69.3	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36	2026-04-28 10:47:23.681105
948	2	kapitan	login	authentication	kapitan logged in	10.29.69.3	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36	2026-04-28 10:47:38.897313
949	3	secretary	login	authentication	secretary logged in	10.29.69.3	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36	2026-04-28 11:33:46.903633
950	7	approver	login	authentication	approver logged in	10.29.69.3	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36	2026-04-28 11:36:32.907167
951	4	treasurer	login	authentication	treasurer logged in	10.27.230.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 12:07:29.10588
952	4	treasurer	logout	authentication	treasurer logged out	10.28.88.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 12:53:34.303951
953	6	council1	login	authentication	council1 logged in	10.28.88.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 12:53:44.01381
954	6	council1	logout	authentication	council1 logged out	10.27.230.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 13:00:56.742639
955	5	bookkeeper	login	authentication	bookkeeper logged in	10.28.88.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 13:01:05.629206
956	5	bookkeeper	logout	authentication	bookkeeper logged out	10.29.69.3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 13:39:59.817762
957	5	bookkeeper	logout	authentication	bookkeeper logged out	10.27.216.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 13:39:59.918369
958	5	bookkeeper	logout	authentication	bookkeeper logged out	10.24.4.132	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 13:40:00.025235
959	7	approver	login	authentication	approver logged in	10.27.216.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 13:41:54.437455
960	1	superadmin	login	authentication	superadmin logged in	10.29.69.3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 13:42:09.511597
961	7	approver	logout	authentication	approver logged out	10.27.230.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 14:24:38.508194
962	1	superadmin	login	authentication	superadmin logged in	10.25.60.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-28 14:24:53.73505
963	4	treasurer	login	authentication	treasurer logged in	10.25.60.130	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-28 14:41:00.718897
964	4	treasurer	login	authentication	treasurer logged in	10.25.60.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-29 00:10:24.811008
965	4	treasurer	login	authentication	treasurer logged in	10.28.88.0	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-29 00:55:36.913287
966	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.28.88.0	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-29 00:56:40.317757
967	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.194.213.12	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-29 00:56:45.316374
968	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.28.88.0	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-29 00:57:03.819505
969	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.28.88.0	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-29 00:57:59.017347
970	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.28.88.0	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-29 00:58:45.618714
971	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.27.230.1	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-29 00:59:15.115692
972	5	bookkeeper	login	authentication	bookkeeper logged in	10.24.4.132	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 [FBAN/FBIOS;FBAV/558.2.0.42.110;FBBV/952277649;FBDV/iPhone11,8;FBMD/iPhone;FBSN/iOS;FBSV/18.7.7;FBSS/2;FBCR/;FBID/phone;FBLC/en_US;FBOP/80]	2026-04-29 02:03:37.701783
973	6	council1	logout	authentication	council1 logged out	10.28.88.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-29 02:15:31.62734
974	4	treasurer	login	authentication	treasurer logged in	10.29.69.3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-29 02:15:40.710328
1007	4	treasurer	DELETE	DFUR Project Management	DFUR project record has been successfully deleted from the system.	10.29.69.3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-29 14:56:52.917609
975	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.29.69.3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-29 02:16:14.720637
976	7	approver	login	authentication	approver logged in	10.27.230.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-29 02:57:01.104212
977	4	treasurer	login	authentication	treasurer logged in	10.25.60.130	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 [FBAN/FBIOS;FBAV/558.2.0.42.110;FBBV/952277649;FBDV/iPhone11,8;FBMD/iPhone;FBSN/iOS;FBSV/18.7.7;FBSS/2;FBCR/;FBID/phone;FBLC/en_US;FBOP/80]	2026-04-29 04:56:20.401783
978	4	treasurer	login	authentication	treasurer logged in	10.28.88.0	Mozilla/5.0 (Linux; Android 13; RMX3085 Build/SP1A.210812.016; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/147.0.7727.55 Mobile Safari/537.36 [FB_IAB/FB4A;FBAV/558.0.0.46.77;]	2026-04-29 05:05:13.319514
979	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.29.69.3	Mozilla/5.0 (Linux; Android 13; RMX3085 Build/SP1A.210812.016; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/147.0.7727.55 Mobile Safari/537.36 [FB_IAB/FB4A;FBAV/558.0.0.46.77;]	2026-04-29 05:09:23.116298
980	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.29.69.3	Mozilla/5.0 (Linux; Android 13; RMX3085 Build/SP1A.210812.016; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/147.0.7727.55 Mobile Safari/537.36 [FB_IAB/FB4A;FBAV/558.0.0.46.77;]	2026-04-29 05:09:53.920611
981	7	approver	logout	authentication	approver logged out	10.27.216.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-29 05:20:23.393165
982	4	treasurer	login	authentication	treasurer logged in	10.29.69.3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-29 05:25:59.329354
983	4	treasurer	logout	authentication	treasurer logged out	10.27.230.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-29 05:31:58.051552
984	4	treasurer	logout	authentication	treasurer logged out	10.28.88.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-29 05:39:55.081339
985	4	treasurer	login	authentication	treasurer logged in	10.28.88.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-29 06:03:36.121072
986	4	treasurer	logout	authentication	treasurer logged out	10.29.69.3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-29 06:25:13.947691
987	4	treasurer	login	authentication	treasurer logged in	10.29.69.3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-29 06:25:30.116968
988	4	treasurer	login	authentication	treasurer logged in	10.27.216.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-29 06:54:08.401612
989	4	treasurer	login	authentication	treasurer logged in	10.27.216.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-29 06:55:39.613229
990	1	superadmin	login	authentication	superadmin logged in	10.27.216.0	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36	2026-04-29 08:07:30.707561
991	1	superadmin	logout	authentication	superadmin logged out	10.29.69.3	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36	2026-04-29 08:08:36.042418
992	1	superadmin	login	authentication	superadmin logged in	10.27.216.0	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36	2026-04-29 08:10:05.614879
993	1	superadmin	logout	authentication	superadmin logged out	10.27.216.0	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36	2026-04-29 08:10:38.518534
994	1	superadmin	login	authentication	superadmin logged in	10.25.60.130	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-29 08:12:10.742944
995	1	superadmin	logout	authentication	superadmin logged out	10.24.4.132	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-29 08:12:33.031704
996	4	treasurer	login	authentication	treasurer logged in	10.27.230.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-29 12:17:01.900264
997	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.27.230.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-29 12:17:31.618742
998	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.25.60.130	PostmanRuntime/7.53.0	2026-04-29 12:18:51.31737
999	4	treasurer	INSERT	Disbursement Management	A new disbursement record has been successfully recorded in the system.	10.25.60.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-29 12:19:34.017672
1000	4	treasurer	login	authentication	treasurer logged in	10.25.60.130	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-29 13:46:36.605206
1001	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.27.230.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-29 14:06:52.317024
1002	4	treasurer	login	authentication	treasurer logged in	10.29.69.3	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-29 14:20:42.713645
1003	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.24.4.132	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-29 14:21:55.621812
1004	4	treasurer	login	authentication	treasurer logged in	10.28.88.0	Mozilla/5.0 (Linux; Android 13; RMX3085 Build/SP1A.210812.016; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/147.0.7727.55 Mobile Safari/537.36 [FB_IAB/FB4A;FBAV/558.0.0.46.77;]	2026-04-29 14:29:04.441738
1005	4	treasurer	logout	authentication	treasurer logged out	10.29.69.3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-29 14:50:11.508651
1008	4	treasurer	DELETE_FAILED	DFUR Project Management	DFUR project record deletion failed. Please verify the record ID and try again.	10.197.84.10	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-29 14:56:58.51836
1009	4	treasurer	DELETE_FAILED	DFUR Project Management	DFUR project record deletion failed. Please verify the record ID and try again.	10.29.69.3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-29 14:57:06.116889
1010	4	treasurer	INSERT_FAILED	Collection Management	Collection record creation failed. The operation could not be completed. Please try again or contact the system administrator.	10.25.60.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-29 14:58:57.518644
1011	4	treasurer	INSERT	Collection Management	A new collection record has been successfully recorded in the system.	10.29.69.3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-29 15:06:00.516705
1012	4	treasurer	INSERT	Collection Management	A new collection record has been successfully recorded in the system.	10.29.69.3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-29 15:06:28.918072
1013	4	treasurer	DELETE	Collection Management	Collection record has been successfully deleted from the system.	10.29.69.3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-29 15:16:13.317862
1014	4	treasurer	INSERT	Collection Management	A new collection record has been successfully recorded in the system.	10.25.60.130	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	2026-04-29 15:20:45.514113
1015	4	treasurer	login	authentication	treasurer logged in	10.28.88.0	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-29 15:28:37.710663
1016	4	treasurer	INSERT	Collection Management	A new collection record has been successfully recorded in the system.	10.25.60.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-29 15:29:52.119967
1017	4	treasurer	logout	authentication	treasurer logged out	10.197.84.10	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-29 15:34:41.271837
1018	4	treasurer	login	authentication	treasurer logged in	10.25.60.130	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-29 15:35:02.820989
1019	4	treasurer	INSERT	Collection Management	A new collection record has been successfully recorded in the system.	10.27.216.0	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-29 15:35:52.519167
1020	4	treasurer	INSERT	Collection Management	A new collection record has been successfully recorded in the system.	10.27.216.0	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-29 15:37:04.250452
1021	4	treasurer	logout	authentication	treasurer logged out	10.27.216.0	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-29 15:37:18.909019
1022	4	treasurer	logout	authentication	treasurer logged out	10.27.230.1	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36	2026-04-29 16:06:29.118078
1023	7	approver	login	authentication	approver logged in	10.27.230.1	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36	2026-04-29 16:06:45.421941
1024	7	approver	logout	authentication	approver logged out	10.25.60.130	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36	2026-04-29 16:16:36.244684
1025	1	superadmin	login	authentication	superadmin logged in	10.25.60.130	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36	2026-04-29 16:16:37.480198
1026	4	treasurer	login	authentication	treasurer logged in	10.199.107.10	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-29 17:58:44.218085
1027	4	treasurer	login	authentication	treasurer logged in	10.199.255.133	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-29 18:41:06.091913
1028	4	treasurer	INSERT	Disbursement Management	A new disbursement record has been successfully recorded in the system.	10.195.174.130	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-29 18:42:34.618379
1029	4	treasurer	UPDATE	Disbursement Management	Disbursement record has been successfully updated.	10.194.156.137	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-29 18:43:26.91705
1030	4	treasurer	logout	authentication	treasurer logged out	10.196.87.138	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-29 18:43:50.33384
1031	4	treasurer	login	authentication	treasurer logged in	10.194.156.137	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-29 21:59:03.992331
1032	4	treasurer	INSERT	Collection Management	A new collection record has been successfully recorded in the system.	10.196.87.138	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-29 22:00:24.416077
1033	4	treasurer	INSERT	Collection Management	A new collection record has been successfully recorded in the system.	10.194.156.137	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-29 22:01:23.817446
1034	4	treasurer	UPDATE	Collection Management	Collection record has been successfully updated.	10.195.174.130	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-29 22:02:50.11855
1035	4	treasurer	logout	authentication	treasurer logged out	10.195.174.130	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-29 22:03:13.041182
1036	4	treasurer	login	authentication	treasurer logged in	10.197.84.12	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-29 23:42:49.189652
1037	4	treasurer	INSERT	Disbursement Management	A new disbursement record has been successfully recorded in the system.	10.199.255.133	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-29 23:43:29.119704
1038	4	treasurer	logout	authentication	treasurer logged out	10.197.84.12	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-29 23:43:37.446656
1039	4	treasurer	login	authentication	treasurer logged in	10.195.174.130	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-29 23:55:01.992574
1040	4	treasurer	INSERT	Collection Management	A new collection record has been successfully recorded in the system.	10.194.156.137	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-29 23:55:52.019056
1041	4	treasurer	logout	authentication	treasurer logged out	10.199.107.10	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-29 23:56:11.299042
1042	7	approver	login	authentication	approver logged in	10.196.87.138	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36	2026-04-30 00:08:58.912987
1043	4	treasurer	login	authentication	treasurer logged in	10.196.87.138	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-30 00:27:46.120141
1044	4	treasurer	login	authentication	treasurer logged in	10.194.156.137	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Mobile Safari/537.36	2026-04-30 04:12:26.00054
1045	4	treasurer	login	authentication	treasurer logged in	10.199.255.133	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-30 05:06:40.704957
1046	4	treasurer	logout	authentication	treasurer logged out	10.199.107.10	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-30 05:08:09.613504
1047	1	superadmin	login	authentication	superadmin logged in	10.197.84.12	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-30 05:24:07.087319
1048	1	superadmin	logout	authentication	superadmin logged out	10.199.107.10	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-30 05:25:30.319913
1049	6	council1	login	authentication	council1 logged in	10.197.84.12	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-30 05:26:01.29509
1050	6	council1	logout	authentication	council1 logged out	10.194.156.137	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-30 05:27:10.859607
1051	6	council1	logout	authentication	council1 logged out	10.196.87.138	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-30 05:27:13.207312
1052	6	council1	logout	authentication	council1 logged out	10.194.156.137	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-30 05:27:20.304254
1053	7	approver	login	authentication	approver logged in	10.194.156.137	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-30 05:27:27.092102
1054	7	approver	logout	authentication	approver logged out	10.199.255.133	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-30 05:29:27.000953
1055	6	council1	login	authentication	council1 logged in	10.195.174.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-30 05:29:49.986856
1056	6	council1	logout	authentication	council1 logged out	10.194.156.137	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-30 05:31:24.029083
1057	4	treasurer	login	authentication	treasurer logged in	10.199.255.133	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-30 05:31:36.624199
1058	4	treasurer	INSERT	DFUR Project Management	A new DFUR project record has been successfully recorded in the system.	10.195.174.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-30 05:32:50.414194
1059	4	treasurer	logout	authentication	treasurer logged out	10.197.84.12	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-30 05:32:54.597155
1060	6	council1	login	authentication	council1 logged in	10.199.107.10	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-30 05:33:01.288432
1061	6	council1	logout	authentication	council1 logged out	10.194.156.137	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-30 05:34:24.099368
1062	6	council1	logout	authentication	council1 logged out	10.194.156.137	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-30 05:34:24.162519
1063	7	approver	login	authentication	approver logged in	10.194.156.137	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-30 05:34:32.185527
1064	7	approver	logout	authentication	approver logged out	10.197.84.12	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-30 05:34:46.025158
1065	7	approver	login	authentication	approver logged in	10.194.156.137	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-30 05:35:11.025598
1066	7	approver	logout	authentication	approver logged out	10.194.156.137	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-30 05:36:19.206412
1067	6	council1	login	authentication	council1 logged in	10.195.174.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-30 05:37:49.930934
1068	6	council1	logout	authentication	council1 logged out	10.195.174.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-30 05:39:48.941329
1069	1	superadmin	login	authentication	superadmin logged in	10.199.107.10	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-30 05:40:00.282694
1070	4	treasurer	login	authentication	treasurer logged in	10.196.87.138	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-30 05:42:59.016094
1071	4	treasurer	logout	authentication	treasurer logged out	10.199.107.10	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-30 05:47:50.789061
1072	4	treasurer	login	authentication	treasurer logged in	10.195.174.130	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-30 06:05:50.299971
1073	4	treasurer	INSERT	Budget Management	A new budget entry has been successfully recorded in the system.	10.199.255.133	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-30 06:07:55.818185
1074	4	treasurer	logout	authentication	treasurer logged out	10.197.84.12	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-30 06:14:00.636976
1075	5	bookkeeper	login	authentication	bookkeeper logged in	10.197.84.12	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-30 06:14:12.991396
1076	5	bookkeeper	INSERT	Collection Management	A review comment has been successfully submitted for Collection record (ID: 173).	10.197.84.12	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-30 06:15:20.816644
1077	5	bookkeeper	INSERT	Disbursement Management	A review comment has been successfully submitted for Disbursement record (ID: 20).	10.196.87.138	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-30 06:16:17.917377
1078	5	bookkeeper	logout	authentication	bookkeeper logged out	10.199.107.10	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-30 06:17:02.107129
1079	7	approver	login	authentication	approver logged in	10.197.84.12	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-30 06:17:13.283018
1080	7	approver	logout	authentication	approver logged out	10.196.87.138	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	2026-04-30 06:20:56.585334
\.


--
-- Data for Name: budget_allocations; Type: TABLE DATA; Schema: public; Owner: barangayfinancetrackdb_user
--

COPY public.budget_allocations (id, category, allocated_amount, utilized_amount, year, created_at) FROM stdin;
1	A. Personal Services	1200000.00	0.00	2026	2026-02-23 01:22:30.447382
2	B. Maintenance and Other Operating Expenses (MOOE)	800000.00	0.00	2026	2026-02-23 01:22:30.447382
3	C. Capital Outlay	500000.00	0.00	2026	2026-02-23 01:22:30.447382
4	D. Special Purpose Appropriations (SPA)	300000.00	0.00	2026	2026-02-23 01:22:30.447382
5	E. Basic Services - Social Services	400000.00	0.00	2026	2026-02-23 01:22:30.447382
6	F. Infrastructure Projects - 20% Development Fund	1000000.00	0.00	2026	2026-02-23 01:22:30.447382
7	G. Other Services	200000.00	0.00	2026	2026-02-23 01:22:30.447382
\.


--
-- Data for Name: budget_entries; Type: TABLE DATA; Schema: public; Owner: barangayfinancetrackdb_user
--

COPY public.budget_entries (id, transaction_id, transaction_date, category, subcategory, amount, fund_source, payee, dv_number, expenditure_program, program_description, remarks, allocation_id, created_by, created_at, file_path, program) FROM stdin;
6	BUDG-2026-001	2026-03-08	B. Maintenance and Other Operating Expenses (MOOE)	Representation Expense	200000.00	Trust Fund	Juan Dela Cruz	50214165161	Representation Expense			1	1	2026-03-07 15:15:16.446427	app/validation_docs\\ANNUAL-BUDGET-ORDINANCE.xlsx	\N
162	BUDG-2026-002	2026-04-16	C. Capital Outlay	Infrastructure Assets- Buildings and Other Structures	500000.00	5% DRRMF	Peter	63815602894	Infrastructure Assets- Buildings and Other Structures			1	1	2026-04-06 00:43:39.241068	\N	\N
163	BUDG-2026-003	2026-04-10	B. Maintenance and Other Operating Expenses (MOOE)	Training Expenses	5000.00	General Fund	XYZ Training Center	41251381438	Training Expenses			1	1	2026-04-11 13:03:06.394236	\N	\N
169	BUDG-2026-005	2026-04-18	A. Personal Services	Cash gift	1231231.00	20% Development Fund	Juan Dela Cruz	76255018759	Cash gift			1	1	2026-04-16 16:14:43.245554	\N	\N
193	BUDG-2026-011	2026-05-07	A. Share from Local Taxes	Share from Real Property Tax	500000.00	General Fund	\N	43965062020	Share from Real Property Tax			1	1	2026-04-30 06:07:55.759216	\N	\N
164	BUDG-2026-004	2026-04-17	C. Capital Outlay	Furniture, Fixtures and Books	12321312.00	General Fund	Peter	70660404738	Furniture, Fixtures and Books			1	1	2026-04-16 00:34:22.886622	\N	\N
170	BUDG-2026-006	2026-04-19	B. Maintenance and Other Operating Expenses (MOOE)	Training Expenses	30000.00	General Fund	John Training Center	17625284947	Training Expenses			1	1	2026-04-19 07:46:06.845428	\N	\N
172	BUDG-2026-007	2026-04-17	B. Maintenance and Other Operating Expenses (MOOE)	Uniforms and Clothing Expenses	121231320.99	5% DRRMF	\N	76807077086	Uniforms and Clothing Expenses			1	1	2026-04-21 15:35:42.520145	\N	\N
175	BUDG-2026-010	2026-04-22	B. Share from National Taxes	Internal Revenue Allotment (IRA) / National Tax Allotment	122222.00	General Fund	\N	94353110003	Internal Revenue Allotment (IRA) / National Tax Allotment			1	1	2026-04-28 06:04:32.538191	\N	\N
190	BUDG-2026-009	2026-04-29	B. Maintenance and Other Operating Expenses (MOOE)	Office Supplies	5000.00	General Fund	Supplier 1	49449707485	Administrative Support	Office operational support activity 1	NaN	1	1	2026-04-29 14:02:35.016575	app/validation_docs/Collections_2026-04-30.pdf	\N
\.


--
-- Data for Name: collections; Type: TABLE DATA; Schema: public; Owner: barangayfinancetrackdb_user
--

COPY public.collections (id, transaction_id, transaction_date, category, amount, payor, nature_of_collection, description, fund_source, or_number, remarks, review_status, is_flagged, is_active, created_at, created_by, file_path) FROM stdin;
145	COLL-2026-011	2026-04-19	\N	1000.00	Zaldy	Other Service Income	\N	General Fund	82140523731		pending	f	t	2026-04-19 07:07:14.590094	1	\N
146	COLL-2026-012	2026-04-19	\N	500.00	Nancy	Barangay Clearance Fees	\N	General Fund	67757896823		pending	f	t	2026-04-19 13:04:22.215567	1	\N
147	COLL-2026-013	2026-04-25	\N	200.00	Alexander Hamilton 	Barangay Business Clearance	\N	General Fund	12901518662		pending	f	t	2026-04-25 06:22:49.915251	1	\N
149	COLL-2026-014	2026-04-28	\N	500000.00	Municipal Treasury	Share from Real Property Tax	\N	General Fund	43516591864		pending	f	t	2026-04-28 05:16:40.399703	1	\N
150	COLL-2026-015	2026-04-28	\N	350000.00	Municipal Treasury	Tax on Sand, Gravel & Other Quarry Resources	\N	General Fund	37736204917		pending	f	t	2026-04-28 05:17:07.578067	1	\N
137	COLL-2026-006	2026-03-14	\N	200.00	Ann Reigo	K.P. Filling fees	\N	General Fund	44222771171		pending	t	t	2026-03-14 05:51:48.66425	1	\N
13	COLL-2026-003	2026-03-02	\N	60000.00		Other Taxes (Community Tax / CTC)	\N	General Fund	45242206260		pending	t	t	2026-03-02 05:51:01.754973	1	\N
16	COLL-2026-005	2026-03-11	\N	50000.00	Municpal treasury	Share from Real Property Tax	\N	General Fund	51613769367		pending	t	t	2026-03-11 02:54:15.168074	1	\N
14	COLL-2026-004	2026-03-02	\N	25000.00	Municipal Treasury	Share from Real Property Tax	\N	General Fund	69529284622		approved	t	t	2026-03-02 05:58:13.973871	1	\N
11	COLL-2026-001	2026-03-02	\N	100.00		Clearance and Certification Fees	\N	General Fund	93279655680		pending	t	t	2026-03-02 03:02:37.318751	1	app/validation_docs/SRE.xlsx
141	COLL-2026-007	2026-03-21	\N	800000.00	Municipal Treasury 	Tax on Sand, Gravel & Other Quarry Resources	\N	Trust Fund	15103086843		pending	t	t	2026-03-21 10:51:54.467969	1	app/validation_docs/SRE.xlsx
12	COLL-2026-002	2026-03-02	\N	200000.00	Municipal Treasury 	Share from Real Property Tax	\N	General Fund	27430127240		approved	t	t	2026-03-02 03:16:10.799875	1	\N
167	COLL-2026-016	2026-04-29	\N	10000.00	Municipal Treasury 	Share from Real Property Tax	\N	General Fund	89124104414		pending	f	t	2026-04-29 15:20:45.421845	1	\N
168	COLL-2026-017	2026-04-29	\N	20000.00	Municipal Treasury	Share from Real Property Tax	\N	General Fund	68164126454		pending	f	t	2026-04-29 15:29:52.088523	1	\N
143	COLL-2026-009	2026-04-14	\N	49999.97	Municipal Treasury 	Tax on Sand, Gravel & Other Quarry Resources	\N	General Fund	86278765186		approved	f	t	2026-04-14 15:06:48.755771	1	app/validation_docs/SRE.xlsx
169	COLL-2026-018	2026-04-29	\N	100000.00	Zamiel Mercadejas	K.P. Filling fees	\N	General Fund	29947168657		pending	f	t	2026-04-29 15:35:52.41918	1	\N
170	COLL-2026-019	2026-04-29	\N	5000000.00	Municipal Treasury 	Share from Real Property Tax	\N	General Fund	33713127547		pending	f	t	2026-04-29 15:37:04.199724	1	\N
171	COLL-2026-020	2026-04-30	\N	50000.00	Lyza Zapanta	Clearance and Certification Fees	\N	General Fund	77299763788		pending	f	t	2026-04-29 22:00:24.396512	1	\N
172	COLL-2026-021	2026-04-30	\N	850000.00	XYZ Company	Other Service Income	\N	General Fund	33828376138		pending	f	t	2026-04-29 22:01:23.731306	1	\N
165	COLL-2026-008	2026-04-29	\N	1220222.00	Municipal Treasury 	Other Taxes (Community Tax / CTC)	\N	Trust Fund	96809683973		pending	f	t	2026-04-29 15:06:00.496531	1	\N
173	COLL-2026-022	2026-04-30	\N	5000000.00	LGU IBA 	Subsidy from National Government	\N	General Fund	63680422102		pending	t	t	2026-04-29 23:55:51.966732	1	\N
\.


--
-- Data for Name: dfur_projects; Type: TABLE DATA; Schema: public; Owner: barangayfinancetrackdb_user
--

COPY public.dfur_projects (id, transaction_id, transaction_date, name_of_collection, project, location, total_cost_approved, total_cost_incurred, date_started, target_completion_date, status, no_extensions, remarks, review_status, is_flagged, is_active, created_at, file_path) FROM stdin;
68	DFUR-2026-006	2026-03-24	Infrastructure	Nanay Bing State University	Iba ZAMBALES	1000000.00	500000.00	2026-03-24	2026-03-24	on_hold	1		pending	t	t	2026-03-23 16:37:22.65084	app/validation_docs/DFUR.xlsx
4	DFUR-2026-002	2026-03-11	Infrastructure	Construction of Barangay Drainage System	Purok 4	60000.00	50000.00	2026-03-11	2026-03-31	in_progress	0	Construction of Barangay Drainage System	approved	t	t	2026-03-11 02:46:32.478038	\N
73	DFUR-2026-008	2026-04-30	Agriculture	Patubig	Purok 1	5000000.00	0.00	2026-04-30	2026-12-03	planned	0		pending	f	t	2026-04-30 05:32:50.402391	\N
65	DFUR-2026-003	2026-03-21	Health	Blood Donation	San Agustin	50000.00	20000.00	2026-03-21	2026-03-21	planned	10		pending	t	t	2026-03-21 10:52:50.98207	\N
3	DFUR-2026-001	2026-02-25	Health	Blood Donation	Barangay San Isidro, District 2	2099999.97	50000.00	2026-02-25	2026-04-18	planned	134		pending	t	t	2026-02-25 13:50:30.15632	\N
69	DFUR-2026-007	2026-03-24	Peace and Order	Peace	Barangay San Isidro, District 2	20000.00	10000.00	2026-03-24	2026-03-24	planned	10		pending	t	t	2026-03-23 17:16:52.032726	\N
66	DFUR-2026-004	2026-03-24	Appropriation & Education	fsadafsd	Barangay San Isidro, District 2	100000.00	122233.00	2026-03-24	2026-03-24	planned	10		pending	t	t	2026-03-23 16:33:14.604995	app/validation_docs/DFUR.xlsx
67	DFUR-2026-005	2026-03-24	Appropriation & Education	fasdfa	Iba ZAMBALES	100000.00	20000.00	2026-03-24	2026-03-24	planned	20		pending	t	t	2026-03-23 16:36:44.604068	app/validation_docs/DFUR.xlsx
\.


--
-- Data for Name: disbursements; Type: TABLE DATA; Schema: public; Owner: barangayfinancetrackdb_user
--

COPY public.disbursements (id, transaction_id, transaction_date, category, subcategory, amount, payee, nature_of_disbursement, description, fund_source, or_number, remarks, review_status, is_flagged, is_active, created_at, created_by, allocation_id, file_path, supporting_doc) FROM stdin;
16	DISB-2026-012	2026-04-19	\N	\N	500.00	Bimby	Tree and Bushes pruning	\N	General Fund	65596710853		pending	f	t	2026-04-19 13:05:45.361201	1	1	\N	\N
5	DISB-2026-002	2026-03-02	\N	\N	150000.00	Brgy Officials	Cash gift	\N	General Fund	25131006122	Every November 	pending	f	t	2026-03-02 03:26:15.63801	1	1	\N	\N
17	DISB-2026-013	2026-04-25	\N	\N	500000.00	Brgy Officials and other staffs of barangay	Uniforms and Clothing Expenses	\N	General Fund	27674063618		pending	f	t	2026-04-25 06:28:52.912124	1	1	\N	\N
12	DISB-2026-009	2026-04-15	\N	\N	40050.00	Ne Dela Cruz	Cash gift	\N	General Fund	13275971655	Paid in cash	pending	f	t	2026-04-15 01:59:59.144705	4	1	\N	app/disbursement-docs/671588166_1435416405003093_7371439961596378731_n.jpg
18	DISB-2026-014	2026-04-29	\N	\N	5656560.00	Ne Dela Cruz	Mid year bonus	\N	Trust Fund	47581195337		pending	f	t	2026-04-29 12:19:33.967703	1	1	\N	\N
9	DISB-2026-006	2026-03-21	\N	\N	500000.00	Juan Dela Cruz	Cash gift	\N	General Fund	18566298731		pending	t	t	2026-03-21 10:52:16.174321	1	1	\N	\N
8	DISB-2026-005	2026-03-14	\N	\N	500000.00	Barangay Officials	Honoraria	\N	General Fund	68510469404		pending	t	t	2026-03-14 05:52:33.224027	1	1	\N	\N
7	DISB-2026-004	2026-03-02	\N	\N	100000.00	Marky	Construction Extension shed of Brgy. Covered Court	\N	20% Development Fund	36509712193		pending	t	t	2026-03-02 06:05:52.489356	1	1	\N	\N
6	DISB-2026-003	2026-03-02	\N	\N	100.00	Marky	Cash gift	\N	General Fund	62308166194		pending	t	t	2026-03-02 03:32:32.080584	1	1	\N	\N
4	DISB-2026-001	2026-03-02	\N	\N	200.00	ZAMECO 1	Electricity Expenses	\N	General Fund	54050988462		pending	t	t	2026-03-02 03:06:43.431992	1	1	\N	\N
10	DISB-2026-007	2026-04-10	\N	\N	5000.00	XYZ Training Center	Training Expenses	\N	General Fund	22894318610	Payment for training materials, handouts, and facilitator fee	pending	t	t	2026-04-10 04:15:53.838148	1	1	\N	\N
11	DISB-2026-008	2026-04-14	\N	\N	10000.00	Juan Dela Cruz	Repairs and Maintenance- Building and Other Structures Maintenance and Repair Expenses	\N	General Fund	51936442030		pending	f	t	2026-04-14 15:19:42.824773	1	1	\N	\N
19	DISB-2026-015	2026-04-30	\N	\N	900000.00	Maxwell Corporation	Fuel, Oil, and Lubricants	\N	General Fund	61204721755		pending	f	t	2026-04-29 18:42:34.51724	1	1	\N	\N
20	DISB-2026-016	2026-04-30	\N	\N	1500000.00	Brgy.Officials and Staffs	Annual leave benefits	\N	General Fund	10323805250		pending	t	t	2026-04-29 23:43:29.060942	1	1	\N	\N
13	DISB-2026-010	2026-04-15	\N	\N	199999.97	Marky	Year end bonus	\N	General Fund	21716072475		pending	f	t	2026-04-15 13:51:34.557793	1	1	\N	\N
15	DISB-2026-011	2026-04-19	\N	\N	20000.00	JBC Training 	Training Expenses	\N	General Fund	34370286795		pending	f	t	2026-04-19 07:43:45.285758	1	1	\N	\N
\.


--
-- Data for Name: flag_comments; Type: TABLE DATA; Schema: public; Owner: barangayfinancetrackdb_user
--

COPY public.flag_comments (id, comment_text, flagged_by, collection_id, disbursement_id, dfur_project_id, created_at, username) FROM stdin;
1	The project has been flagged due to missing supporting documents. Kindly submit the required attachments to proceed with approval.	5	\N	\N	4	2026-03-16 08:19:32.279849	bookkeeper
2	fasdfa	5	12	\N	\N	2026-03-23 16:00:25.495759	bookkeeper
5	fasdfas	5	\N	9	\N	2026-03-23 16:08:48.706352	bookkeeper
8	fasdfads	7	\N	8	\N	2026-03-23 16:29:46.492435	approver
17	The project has been flagged due to missing supporting documents. Kindly submit the required attachments to proceed with approval.	5	141	\N	\N	2026-03-24 12:43:15.890472	bookkeeper
21	The project has been flagged due to missing supporting documents. Kindly submit the required attachments to proceed with approval.	5	\N	7	\N	2026-03-24 13:19:51.69745	bookkeeper
24	The project has been flagged due to missing supporting documents. Kindly submit the required attachments to proceed with approval.	5	\N	\N	3	2026-03-24 13:39:46.929727	bookkeeper
26	The project has been flagged due to missing supporting documents. Kindly submit the required attachments to proceed with approval.	5	\N	\N	65	2026-03-24 13:42:41.092509	bookkeeper
27	The project has been flagged due to missing supporting documents. Kindly submit the required attachments to proceed with approval.	5	\N	\N	66	2026-03-24 13:42:57.643389	bookkeeper
28	The project has been flagged due to missing supporting documents. Kindly submit the required attachments to proceed with approval.	5	\N	\N	67	2026-03-24 13:43:28.729571	bookkeeper
29	The project has been flagged due to missing supporting documents. Kindly submit the required attachments to proceed with approval.	5	\N	\N	68	2026-03-24 13:43:48.2273	bookkeeper
30	The project has been flagged due to missing supporting documents. Kindly submit the required attachments to proceed with approval.	5	\N	\N	69	2026-03-24 13:44:09.695606	bookkeeper
31	fasdfads	5	137	\N	\N	2026-03-24 14:48:19.494838	bookkeeper
32	fadfa	5	13	\N	\N	2026-04-05 10:10:22.798178	bookkeeper
33	fdsafasdfadsf	11	11	\N	\N	2026-04-05 10:40:43.590272	checker
34	fasdfasdf	11	\N	\N	3	2026-04-05 11:21:13.294721	checker
35	fasdfads	7	\N	\N	65	2026-04-05 15:16:02.495614	approver
36	fasdfasd	12	\N	\N	3	2026-04-05 15:16:20.297843	newapprover
37	fasdfa	12	\N	\N	69	2026-04-05 15:16:44.694626	newapprover
38	asdfadf	7	13	\N	\N	2026-04-05 15:21:24.604918	approver
39	fadfads	12	13	\N	\N	2026-04-05 15:21:59.200841	newapprover
40	fsadfsad	7	\N	6	\N	2026-04-05 15:22:17.793074	approver
41	fasdfasd	12	\N	6	\N	2026-04-05 15:22:38.395258	newapprover
42	wefewfwef	7	16	\N	\N	2026-04-07 23:56:58.517571	approver
43	dwdqdwqdq	7	14	\N	\N	2026-04-07 23:57:17.913154	approver
44	wqfqfq	7	\N	4	\N	2026-04-07 23:58:26.721614	approver
45	fewfe	7	12	\N	\N	2026-04-07 23:59:46.515267	approver
46	Can you include the Disbursement Voucher document	7	\N	10	\N	2026-04-10 04:16:58.12219	approver
47	suspicious transaction	5	173	\N	\N	2026-04-30 06:15:20.719788	bookkeeper
48	suspicious	5	\N	20	\N	2026-04-30 06:16:17.817664	bookkeeper
\.


--
-- Data for Name: tables; Type: TABLE DATA; Schema: public; Owner: barangayfinancetrackdb_user
--

COPY public.tables (table_name) FROM stdin;
users
disbursements
budget_allocations
budget_entries
collections
dfur_projects
viewer_comments
activity_logs
flag_comments
tables
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: barangayfinancetrackdb_user
--

COPY public.users (id, username, password, role, full_name, "position", is_active, last_login, created_at, updated_at) FROM stdin;
2	kapitan	$2b$12$.M62elKD/mk2Ema.xQQnTeAB6OxajwKwyZ.Ltg6lkJbDxm8SIz.Xy	admin	Barangay Captain	Kapitan	t	\N	2026-02-22 05:56:43.961064	2026-02-22 05:56:43.961064
5	bookkeeper	$2b$12$/1/RJb.zTq9f9avtEipiAunmrA5jQd6xCj3zZg0WXE8xhNoVicbRS	checker	Barangay Bookkeeper	Bookkeeper	t	\N	2026-02-22 05:56:43.961064	2026-02-22 05:56:43.961064
6	council1	$2b$12$RN/PRQCWPUW6aPn2P4fpH.wb7sPHtMeO1XwsycCbHbKilozGMzTT2	reviewer	Barangay Councilor 1	Barangay Council	t	\N	2026-02-22 05:56:43.961064	2026-02-22 05:56:43.961064
7	approver	$2b$12$TV/iEyh46GYOdIDiGDWjmeeJ61/EylbKRYQkCQ668YtQMwmmDTILe	approver	Budget Approver	Kapitan	t	\N	2026-02-22 05:56:43.961064	2026-02-22 05:56:43.961064
9	DDM	$2b$12$zLTsk2qyhL63mC2UJ12PP.S4V4udKxSVREeQ/xQNBKkMx79MtDC72	superadmin	asdfgh	standing	f	\N	2026-03-02 07:12:28.49133	2026-03-02 07:12:28.49133
1	superadmin	$2b$12$9hCF7NzrrXZDFeohTMy4uedUhSX2lnZKzbR/sDJS.hrxIKwWfJrG2	superadmin	System Administrator	Super Admin	t	\N	2026-02-22 05:56:43.961064	2026-02-22 05:56:43.961064
3	secretary	$2b$12$03lPBKzcKnrq468ig5aBbupp/uifd2YJcbq/U9WTNll5x/wPFz80q	admin	Barangay Secretary	Secretary	f	\N	2026-02-22 05:56:43.961064	2026-02-22 05:56:43.961064
10	encoder	$2b$12$7uWmAa5rxgssIRNHyFiX1.5qlEQnJSlOL8tEq6YkY7FZGH1YIanWS	encoder	Encoder	Treasurer	t	\N	2026-04-05 09:45:16.334143	2026-04-05 09:45:16.334143
11	checker	$2b$12$1Zo.YFD/U1o.5d6D5dSlo.XfG//KKkYrXTGWtuRJCDqVynNwMkuLC	checker	Checker	Barangay Bookeeper	t	\N	2026-04-05 09:46:55.611229	2026-04-05 09:46:55.611229
12	newapprover	$2b$12$B44E8u2Fjneqj1eY.BXGxu5jB2YbmmN3zJjTQuP12RsMNKnIwutBy	approver	Approver 2	Barangay Approver	f	\N	2026-04-05 14:37:08.896456	2026-04-05 14:37:08.896456
4	treasurer	$2b$12$J4LI/6zxmB9zu1is16zWy./dEBemeniXTZtC4o7eIXifOcb7ouf06	encoder	Barangay Treasurer	Treasurer	t	\N	2026-02-22 05:56:43.961064	2026-02-22 05:56:43.961064
\.


--
-- Data for Name: viewer_comments; Type: TABLE DATA; Schema: public; Owner: barangayfinancetrackdb_user
--

COPY public.viewer_comments (id, comment, name, email, created_at) FROM stdin;
1	Thank you for making the barangay financial records transparent.	Anonymous		2026-03-05 03:50:08.992848
2	hdhghjf	Anonymous		2026-03-05 03:56:48.796992
3	chlfohfljfjgkgoho	princess		2026-03-05 03:57:31.643268
4	I appreciate the regular updates on barangay expenses	Anonymous		2026-03-05 03:58:00.689649
5	Hi	Anonymous		2026-03-05 03:59:33.403089
6	gjgkvkvm	cc		2026-03-05 03:59:49.24454
7	I appreciate the regular updates on barangay expenses.	Anonymous		2026-03-05 05:34:19.884909
8	I appreciate the transparency of this platform in showing how barangay funds are being allocated. It helps residents like me understand where the budget is going. It would be even better if project updates and completion status were included so we can track progress.	John Joe	john@gmail.com	2026-03-09 00:27:06.691462
9	.	Anonymous		2026-03-09 11:29:00.908463
11	.	Anonymous		2026-03-11 01:40:11.291687
12	Perfect	Jj		2026-03-25 16:00:25.531994
13	gggggg\n	gg		2026-04-19 07:12:56.526006
14	thesis defended	Anonymous	miradornicole29@gmail.com	2026-04-30 06:04:24.62595
\.


--
-- Name: activity_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: barangayfinancetrackdb_user
--

SELECT pg_catalog.setval('public.activity_logs_id_seq', 1080, true);


--
-- Name: budget_allocations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: barangayfinancetrackdb_user
--

SELECT pg_catalog.setval('public.budget_allocations_id_seq', 7, true);


--
-- Name: budget_entries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: barangayfinancetrackdb_user
--

SELECT pg_catalog.setval('public.budget_entries_id_seq', 193, true);


--
-- Name: collections_id_seq; Type: SEQUENCE SET; Schema: public; Owner: barangayfinancetrackdb_user
--

SELECT pg_catalog.setval('public.collections_id_seq', 173, true);


--
-- Name: dfur_projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: barangayfinancetrackdb_user
--

SELECT pg_catalog.setval('public.dfur_projects_id_seq', 73, true);


--
-- Name: disbursements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: barangayfinancetrackdb_user
--

SELECT pg_catalog.setval('public.disbursements_id_seq', 20, true);


--
-- Name: flag_comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: barangayfinancetrackdb_user
--

SELECT pg_catalog.setval('public.flag_comments_id_seq', 48, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: barangayfinancetrackdb_user
--

SELECT pg_catalog.setval('public.users_id_seq', 12, true);


--
-- Name: viewer_comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: barangayfinancetrackdb_user
--

SELECT pg_catalog.setval('public.viewer_comments_id_seq', 14, true);


--
-- Name: activity_logs activity_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: barangayfinancetrackdb_user
--

ALTER TABLE ONLY public.activity_logs
    ADD CONSTRAINT activity_logs_pkey PRIMARY KEY (id);


--
-- Name: budget_allocations budget_allocations_pkey; Type: CONSTRAINT; Schema: public; Owner: barangayfinancetrackdb_user
--

ALTER TABLE ONLY public.budget_allocations
    ADD CONSTRAINT budget_allocations_pkey PRIMARY KEY (id);


--
-- Name: budget_entries budget_entries_pkey; Type: CONSTRAINT; Schema: public; Owner: barangayfinancetrackdb_user
--

ALTER TABLE ONLY public.budget_entries
    ADD CONSTRAINT budget_entries_pkey PRIMARY KEY (id);


--
-- Name: budget_entries budget_entries_transaction_id_key; Type: CONSTRAINT; Schema: public; Owner: barangayfinancetrackdb_user
--

ALTER TABLE ONLY public.budget_entries
    ADD CONSTRAINT budget_entries_transaction_id_key UNIQUE (transaction_id);


--
-- Name: collections collections_pkey; Type: CONSTRAINT; Schema: public; Owner: barangayfinancetrackdb_user
--

ALTER TABLE ONLY public.collections
    ADD CONSTRAINT collections_pkey PRIMARY KEY (id);


--
-- Name: collections collections_transaction_id_key; Type: CONSTRAINT; Schema: public; Owner: barangayfinancetrackdb_user
--

ALTER TABLE ONLY public.collections
    ADD CONSTRAINT collections_transaction_id_key UNIQUE (transaction_id);


--
-- Name: dfur_projects dfur_projects_pkey; Type: CONSTRAINT; Schema: public; Owner: barangayfinancetrackdb_user
--

ALTER TABLE ONLY public.dfur_projects
    ADD CONSTRAINT dfur_projects_pkey PRIMARY KEY (id);


--
-- Name: dfur_projects dfur_projects_transaction_id_key; Type: CONSTRAINT; Schema: public; Owner: barangayfinancetrackdb_user
--

ALTER TABLE ONLY public.dfur_projects
    ADD CONSTRAINT dfur_projects_transaction_id_key UNIQUE (transaction_id);


--
-- Name: disbursements disbursements_pkey; Type: CONSTRAINT; Schema: public; Owner: barangayfinancetrackdb_user
--

ALTER TABLE ONLY public.disbursements
    ADD CONSTRAINT disbursements_pkey PRIMARY KEY (id);


--
-- Name: disbursements disbursements_transaction_id_key; Type: CONSTRAINT; Schema: public; Owner: barangayfinancetrackdb_user
--

ALTER TABLE ONLY public.disbursements
    ADD CONSTRAINT disbursements_transaction_id_key UNIQUE (transaction_id);


--
-- Name: flag_comments flag_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: barangayfinancetrackdb_user
--

ALTER TABLE ONLY public.flag_comments
    ADD CONSTRAINT flag_comments_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: barangayfinancetrackdb_user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: barangayfinancetrackdb_user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: viewer_comments viewer_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: barangayfinancetrackdb_user
--

ALTER TABLE ONLY public.viewer_comments
    ADD CONSTRAINT viewer_comments_pkey PRIMARY KEY (id);


--
-- Name: budget_entries budget_entries_allocation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: barangayfinancetrackdb_user
--

ALTER TABLE ONLY public.budget_entries
    ADD CONSTRAINT budget_entries_allocation_id_fkey FOREIGN KEY (allocation_id) REFERENCES public.budget_allocations(id);


--
-- Name: budget_entries budget_entries_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: barangayfinancetrackdb_user
--

ALTER TABLE ONLY public.budget_entries
    ADD CONSTRAINT budget_entries_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- Name: collections collections_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: barangayfinancetrackdb_user
--

ALTER TABLE ONLY public.collections
    ADD CONSTRAINT collections_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- Name: disbursements disbursements_allocation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: barangayfinancetrackdb_user
--

ALTER TABLE ONLY public.disbursements
    ADD CONSTRAINT disbursements_allocation_id_fkey FOREIGN KEY (allocation_id) REFERENCES public.budget_allocations(id);


--
-- Name: disbursements disbursements_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: barangayfinancetrackdb_user
--

ALTER TABLE ONLY public.disbursements
    ADD CONSTRAINT disbursements_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- Name: flag_comments fk_collection; Type: FK CONSTRAINT; Schema: public; Owner: barangayfinancetrackdb_user
--

ALTER TABLE ONLY public.flag_comments
    ADD CONSTRAINT fk_collection FOREIGN KEY (collection_id) REFERENCES public.collections(id) ON DELETE CASCADE;


--
-- Name: flag_comments fk_dfur_projects; Type: FK CONSTRAINT; Schema: public; Owner: barangayfinancetrackdb_user
--

ALTER TABLE ONLY public.flag_comments
    ADD CONSTRAINT fk_dfur_projects FOREIGN KEY (dfur_project_id) REFERENCES public.dfur_projects(id);


--
-- Name: flag_comments fk_disbursement; Type: FK CONSTRAINT; Schema: public; Owner: barangayfinancetrackdb_user
--

ALTER TABLE ONLY public.flag_comments
    ADD CONSTRAINT fk_disbursement FOREIGN KEY (disbursement_id) REFERENCES public.disbursements(id) ON DELETE CASCADE;


--
-- Name: activity_logs fk_user; Type: FK CONSTRAINT; Schema: public; Owner: barangayfinancetrackdb_user
--

ALTER TABLE ONLY public.activity_logs
    ADD CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: flag_comments fk_users; Type: FK CONSTRAINT; Schema: public; Owner: barangayfinancetrackdb_user
--

ALTER TABLE ONLY public.flag_comments
    ADD CONSTRAINT fk_users FOREIGN KEY (flagged_by) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON SEQUENCES TO barangayfinancetrackdb_user;


--
-- Name: DEFAULT PRIVILEGES FOR TYPES; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON TYPES TO barangayfinancetrackdb_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON FUNCTIONS TO barangayfinancetrackdb_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON TABLES TO barangayfinancetrackdb_user;


--
-- PostgreSQL database dump complete
--

\unrestrict iD4m0SfR7uE1sj5QfS2omKVvcOecO7iSQi40lJVGPwYq4i5fL2HPufdcmgBpklL

