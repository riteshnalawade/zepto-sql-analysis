--
-- PostgreSQL database dump
--

\restrict gu6h8XwclMvmNFR6HrEx5MpSLstiTKo3vfqDmaUYSSz1fYewDLbqIRiT0ztIvmd

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

-- Started on 2026-04-26 21:42:07

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
-- TOC entry 6 (class 2615 OID 16793)
-- Name: zepto; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA zepto;


ALTER SCHEMA zepto OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 221 (class 1259 OID 16795)
-- Name: customers; Type: TABLE; Schema: zepto; Owner: postgres
--

CREATE TABLE zepto.customers (
    customer_id integer NOT NULL,
    name character varying(80) NOT NULL,
    email character varying(120) NOT NULL,
    contact character varying(15) NOT NULL,
    gender character varying(10),
    date_of_birth date,
    address text,
    city character varying(40),
    state character varying(40),
    pincode character varying(10),
    signup_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    customer_segment character varying(20),
    is_active boolean DEFAULT true,
    CONSTRAINT customers_customer_segment_check CHECK (((customer_segment)::text = ANY ((ARRAY['New'::character varying, 'Regular'::character varying, 'Premium'::character varying, 'Inactive'::character varying])::text[]))),
    CONSTRAINT customers_gender_check CHECK (((gender)::text = ANY ((ARRAY['Male'::character varying, 'Female'::character varying, 'Other'::character varying])::text[])))
);


ALTER TABLE zepto.customers OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16794)
-- Name: customers_customer_id_seq; Type: SEQUENCE; Schema: zepto; Owner: postgres
--

CREATE SEQUENCE zepto.customers_customer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE zepto.customers_customer_id_seq OWNER TO postgres;

--
-- TOC entry 5149 (class 0 OID 0)
-- Dependencies: 220
-- Name: customers_customer_id_seq; Type: SEQUENCE OWNED BY; Schema: zepto; Owner: postgres
--

ALTER SEQUENCE zepto.customers_customer_id_seq OWNED BY zepto.customers.customer_id;


--
-- TOC entry 235 (class 1259 OID 16940)
-- Name: deliveries; Type: TABLE; Schema: zepto; Owner: postgres
--

CREATE TABLE zepto.deliveries (
    delivery_id integer NOT NULL,
    order_id integer NOT NULL,
    partner_id integer,
    assigned_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    picked_up_at timestamp without time zone,
    delivered_at timestamp without time zone,
    delivery_minutes integer,
    delivery_rating numeric(2,1),
    status character varying(20),
    CONSTRAINT deliveries_delivery_rating_check CHECK (((delivery_rating >= (1)::numeric) AND (delivery_rating <= (5)::numeric))),
    CONSTRAINT deliveries_status_check CHECK (((status)::text = ANY ((ARRAY['assigned'::character varying, 'picked up'::character varying, 'delivered'::character varying, 'failed'::character varying, 'returned'::character varying])::text[])))
);


ALTER TABLE zepto.deliveries OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 16939)
-- Name: deliveries_delivery_id_seq; Type: SEQUENCE; Schema: zepto; Owner: postgres
--

CREATE SEQUENCE zepto.deliveries_delivery_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE zepto.deliveries_delivery_id_seq OWNER TO postgres;

--
-- TOC entry 5150 (class 0 OID 0)
-- Dependencies: 234
-- Name: deliveries_delivery_id_seq; Type: SEQUENCE OWNED BY; Schema: zepto; Owner: postgres
--

ALTER SEQUENCE zepto.deliveries_delivery_id_seq OWNED BY zepto.deliveries.delivery_id;


--
-- TOC entry 229 (class 1259 OID 16875)
-- Name: delivery_partners; Type: TABLE; Schema: zepto; Owner: postgres
--

CREATE TABLE zepto.delivery_partners (
    partner_id integer NOT NULL,
    name character varying(60) NOT NULL,
    phone character varying(15) NOT NULL,
    vehicle_type character varying(20),
    city character varying(40),
    state character varying(40),
    pincode character varying(10),
    joined_on date,
    status character varying(20),
    CONSTRAINT delivery_partners_status_check CHECK (((status)::text = ANY ((ARRAY['available'::character varying, 'not available'::character varying, 'on delivery'::character varying, 'offline'::character varying])::text[]))),
    CONSTRAINT delivery_partners_vehicle_type_check CHECK (((vehicle_type)::text = ANY ((ARRAY['Bike'::character varying, 'EV Scooty'::character varying, 'Scooty'::character varying, 'Cycle'::character varying])::text[])))
);


ALTER TABLE zepto.delivery_partners OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16874)
-- Name: delivery_partners_partner_id_seq; Type: SEQUENCE; Schema: zepto; Owner: postgres
--

CREATE SEQUENCE zepto.delivery_partners_partner_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE zepto.delivery_partners_partner_id_seq OWNER TO postgres;

--
-- TOC entry 5151 (class 0 OID 0)
-- Dependencies: 228
-- Name: delivery_partners_partner_id_seq; Type: SEQUENCE OWNED BY; Schema: zepto; Owner: postgres
--

ALTER SEQUENCE zepto.delivery_partners_partner_id_seq OWNED BY zepto.delivery_partners.partner_id;


--
-- TOC entry 227 (class 1259 OID 16849)
-- Name: inventory; Type: TABLE; Schema: zepto; Owner: postgres
--

CREATE TABLE zepto.inventory (
    inventory_id integer NOT NULL,
    store_id integer NOT NULL,
    product_id integer NOT NULL,
    quantity integer NOT NULL,
    reorder_level integer DEFAULT 20,
    last_updated timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT inventory_quantity_check CHECK ((quantity >= 0))
);


ALTER TABLE zepto.inventory OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16848)
-- Name: inventory_inventory_id_seq; Type: SEQUENCE; Schema: zepto; Owner: postgres
--

CREATE SEQUENCE zepto.inventory_inventory_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE zepto.inventory_inventory_id_seq OWNER TO postgres;

--
-- TOC entry 5152 (class 0 OID 0)
-- Dependencies: 226
-- Name: inventory_inventory_id_seq; Type: SEQUENCE OWNED BY; Schema: zepto; Owner: postgres
--

ALTER SEQUENCE zepto.inventory_inventory_id_seq OWNED BY zepto.inventory.inventory_id;


--
-- TOC entry 233 (class 1259 OID 16916)
-- Name: order_items; Type: TABLE; Schema: zepto; Owner: postgres
--

CREATE TABLE zepto.order_items (
    order_item_id integer NOT NULL,
    order_id integer NOT NULL,
    product_id integer NOT NULL,
    quantity integer NOT NULL,
    unit_price numeric(10,2) NOT NULL,
    line_total numeric(10,2) GENERATED ALWAYS AS (((quantity)::numeric * unit_price)) STORED,
    CONSTRAINT order_items_quantity_check CHECK ((quantity > 0))
);


ALTER TABLE zepto.order_items OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 16915)
-- Name: order_items_order_item_id_seq; Type: SEQUENCE; Schema: zepto; Owner: postgres
--

CREATE SEQUENCE zepto.order_items_order_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE zepto.order_items_order_item_id_seq OWNER TO postgres;

--
-- TOC entry 5153 (class 0 OID 0)
-- Dependencies: 232
-- Name: order_items_order_item_id_seq; Type: SEQUENCE OWNED BY; Schema: zepto; Owner: postgres
--

ALTER SEQUENCE zepto.order_items_order_item_id_seq OWNED BY zepto.order_items.order_item_id;


--
-- TOC entry 231 (class 1259 OID 16889)
-- Name: orders; Type: TABLE; Schema: zepto; Owner: postgres
--

CREATE TABLE zepto.orders (
    order_id integer NOT NULL,
    customer_id integer NOT NULL,
    store_id integer NOT NULL,
    order_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    sub_total numeric(10,2) NOT NULL,
    discount_amt numeric(10,2) DEFAULT 0,
    delivery_fee numeric(10,2) DEFAULT 0,
    total_amount numeric(10,2) NOT NULL,
    promo_code character varying(20),
    status character varying(20),
    CONSTRAINT orders_status_check CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'picked up'::character varying, 'delivered'::character varying, 'cancelled'::character varying, 'returned'::character varying])::text[])))
);


ALTER TABLE zepto.orders OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16888)
-- Name: orders_order_id_seq; Type: SEQUENCE; Schema: zepto; Owner: postgres
--

CREATE SEQUENCE zepto.orders_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE zepto.orders_order_id_seq OWNER TO postgres;

--
-- TOC entry 5154 (class 0 OID 0)
-- Dependencies: 230
-- Name: orders_order_id_seq; Type: SEQUENCE OWNED BY; Schema: zepto; Owner: postgres
--

ALTER SEQUENCE zepto.orders_order_id_seq OWNED BY zepto.orders.order_id;


--
-- TOC entry 237 (class 1259 OID 16964)
-- Name: payments; Type: TABLE; Schema: zepto; Owner: postgres
--

CREATE TABLE zepto.payments (
    payment_id integer NOT NULL,
    order_id integer NOT NULL,
    payment_method character varying(20),
    amount numeric(10,2) NOT NULL,
    payment_status character varying(20),
    paid_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT payments_payment_method_check CHECK (((payment_method)::text = ANY ((ARRAY['UPI'::character varying, 'Credit Card'::character varying, 'Debit Card'::character varying, 'COD'::character varying, 'Wallet'::character varying, 'Net Banking'::character varying])::text[]))),
    CONSTRAINT payments_payment_status_check CHECK (((payment_status)::text = ANY ((ARRAY['success'::character varying, 'failed'::character varying, 'pending'::character varying, 'refunded'::character varying])::text[])))
);


ALTER TABLE zepto.payments OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 16963)
-- Name: payments_payment_id_seq; Type: SEQUENCE; Schema: zepto; Owner: postgres
--

CREATE SEQUENCE zepto.payments_payment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE zepto.payments_payment_id_seq OWNER TO postgres;

--
-- TOC entry 5155 (class 0 OID 0)
-- Dependencies: 236
-- Name: payments_payment_id_seq; Type: SEQUENCE OWNED BY; Schema: zepto; Owner: postgres
--

ALTER SEQUENCE zepto.payments_payment_id_seq OWNED BY zepto.payments.payment_id;


--
-- TOC entry 239 (class 1259 OID 16984)
-- Name: product_reviews; Type: TABLE; Schema: zepto; Owner: postgres
--

CREATE TABLE zepto.product_reviews (
    review_id integer NOT NULL,
    product_id integer NOT NULL,
    customer_id integer NOT NULL,
    order_id integer,
    rating integer,
    review_text text,
    review_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT product_reviews_rating_check CHECK (((rating >= 1) AND (rating <= 5)))
);


ALTER TABLE zepto.product_reviews OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 16983)
-- Name: product_reviews_review_id_seq; Type: SEQUENCE; Schema: zepto; Owner: postgres
--

CREATE SEQUENCE zepto.product_reviews_review_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE zepto.product_reviews_review_id_seq OWNER TO postgres;

--
-- TOC entry 5156 (class 0 OID 0)
-- Dependencies: 238
-- Name: product_reviews_review_id_seq; Type: SEQUENCE OWNED BY; Schema: zepto; Owner: postgres
--

ALTER SEQUENCE zepto.product_reviews_review_id_seq OWNED BY zepto.product_reviews.review_id;


--
-- TOC entry 225 (class 1259 OID 16833)
-- Name: products; Type: TABLE; Schema: zepto; Owner: postgres
--

CREATE TABLE zepto.products (
    product_id integer NOT NULL,
    product_name character varying(120) NOT NULL,
    category character varying(40),
    sub_category character varying(40),
    brand character varying(50),
    unit character varying(20),
    mrp numeric(10,2) NOT NULL,
    selling_price numeric(10,2) NOT NULL,
    is_perishable boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    is_active boolean DEFAULT true,
    CONSTRAINT products_check CHECK ((selling_price <= mrp)),
    CONSTRAINT products_selling_price_check CHECK ((selling_price > (0)::numeric))
);


ALTER TABLE zepto.products OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16832)
-- Name: products_product_id_seq; Type: SEQUENCE; Schema: zepto; Owner: postgres
--

CREATE SEQUENCE zepto.products_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE zepto.products_product_id_seq OWNER TO postgres;

--
-- TOC entry 5157 (class 0 OID 0)
-- Dependencies: 224
-- Name: products_product_id_seq; Type: SEQUENCE OWNED BY; Schema: zepto; Owner: postgres
--

ALTER SEQUENCE zepto.products_product_id_seq OWNED BY zepto.products.product_id;


--
-- TOC entry 223 (class 1259 OID 16817)
-- Name: stores; Type: TABLE; Schema: zepto; Owner: postgres
--

CREATE TABLE zepto.stores (
    store_id integer NOT NULL,
    store_name character varying(80) NOT NULL,
    address text,
    city character varying(40),
    state character varying(40),
    pincode character varying(10),
    manager_name character varying(60) NOT NULL,
    contact character varying(15) NOT NULL,
    opened_on date,
    is_active boolean DEFAULT true
);


ALTER TABLE zepto.stores OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16816)
-- Name: stores_store_id_seq; Type: SEQUENCE; Schema: zepto; Owner: postgres
--

CREATE SEQUENCE zepto.stores_store_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE zepto.stores_store_id_seq OWNER TO postgres;

--
-- TOC entry 5158 (class 0 OID 0)
-- Dependencies: 222
-- Name: stores_store_id_seq; Type: SEQUENCE OWNED BY; Schema: zepto; Owner: postgres
--

ALTER SEQUENCE zepto.stores_store_id_seq OWNED BY zepto.stores.store_id;


--
-- TOC entry 4902 (class 2604 OID 16798)
-- Name: customers customer_id; Type: DEFAULT; Schema: zepto; Owner: postgres
--

ALTER TABLE ONLY zepto.customers ALTER COLUMN customer_id SET DEFAULT nextval('zepto.customers_customer_id_seq'::regclass);


--
-- TOC entry 4921 (class 2604 OID 16943)
-- Name: deliveries delivery_id; Type: DEFAULT; Schema: zepto; Owner: postgres
--

ALTER TABLE ONLY zepto.deliveries ALTER COLUMN delivery_id SET DEFAULT nextval('zepto.deliveries_delivery_id_seq'::regclass);


--
-- TOC entry 4914 (class 2604 OID 16878)
-- Name: delivery_partners partner_id; Type: DEFAULT; Schema: zepto; Owner: postgres
--

ALTER TABLE ONLY zepto.delivery_partners ALTER COLUMN partner_id SET DEFAULT nextval('zepto.delivery_partners_partner_id_seq'::regclass);


--
-- TOC entry 4911 (class 2604 OID 16852)
-- Name: inventory inventory_id; Type: DEFAULT; Schema: zepto; Owner: postgres
--

ALTER TABLE ONLY zepto.inventory ALTER COLUMN inventory_id SET DEFAULT nextval('zepto.inventory_inventory_id_seq'::regclass);


--
-- TOC entry 4919 (class 2604 OID 16919)
-- Name: order_items order_item_id; Type: DEFAULT; Schema: zepto; Owner: postgres
--

ALTER TABLE ONLY zepto.order_items ALTER COLUMN order_item_id SET DEFAULT nextval('zepto.order_items_order_item_id_seq'::regclass);


--
-- TOC entry 4915 (class 2604 OID 16892)
-- Name: orders order_id; Type: DEFAULT; Schema: zepto; Owner: postgres
--

ALTER TABLE ONLY zepto.orders ALTER COLUMN order_id SET DEFAULT nextval('zepto.orders_order_id_seq'::regclass);


--
-- TOC entry 4923 (class 2604 OID 16967)
-- Name: payments payment_id; Type: DEFAULT; Schema: zepto; Owner: postgres
--

ALTER TABLE ONLY zepto.payments ALTER COLUMN payment_id SET DEFAULT nextval('zepto.payments_payment_id_seq'::regclass);


--
-- TOC entry 4925 (class 2604 OID 16987)
-- Name: product_reviews review_id; Type: DEFAULT; Schema: zepto; Owner: postgres
--

ALTER TABLE ONLY zepto.product_reviews ALTER COLUMN review_id SET DEFAULT nextval('zepto.product_reviews_review_id_seq'::regclass);


--
-- TOC entry 4907 (class 2604 OID 16836)
-- Name: products product_id; Type: DEFAULT; Schema: zepto; Owner: postgres
--

ALTER TABLE ONLY zepto.products ALTER COLUMN product_id SET DEFAULT nextval('zepto.products_product_id_seq'::regclass);


--
-- TOC entry 4905 (class 2604 OID 16820)
-- Name: stores store_id; Type: DEFAULT; Schema: zepto; Owner: postgres
--

ALTER TABLE ONLY zepto.stores ALTER COLUMN store_id SET DEFAULT nextval('zepto.stores_store_id_seq'::regclass);


--
-- TOC entry 4942 (class 2606 OID 16815)
-- Name: customers customers_contact_key; Type: CONSTRAINT; Schema: zepto; Owner: postgres
--

ALTER TABLE ONLY zepto.customers
    ADD CONSTRAINT customers_contact_key UNIQUE (contact);


--
-- TOC entry 4944 (class 2606 OID 16813)
-- Name: customers customers_email_key; Type: CONSTRAINT; Schema: zepto; Owner: postgres
--

ALTER TABLE ONLY zepto.customers
    ADD CONSTRAINT customers_email_key UNIQUE (email);


--
-- TOC entry 4946 (class 2606 OID 16811)
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: zepto; Owner: postgres
--

ALTER TABLE ONLY zepto.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (customer_id);


--
-- TOC entry 4974 (class 2606 OID 16952)
-- Name: deliveries deliveries_order_id_key; Type: CONSTRAINT; Schema: zepto; Owner: postgres
--

ALTER TABLE ONLY zepto.deliveries
    ADD CONSTRAINT deliveries_order_id_key UNIQUE (order_id);


--
-- TOC entry 4976 (class 2606 OID 16950)
-- Name: deliveries deliveries_pkey; Type: CONSTRAINT; Schema: zepto; Owner: postgres
--

ALTER TABLE ONLY zepto.deliveries
    ADD CONSTRAINT deliveries_pkey PRIMARY KEY (delivery_id);


--
-- TOC entry 4960 (class 2606 OID 16887)
-- Name: delivery_partners delivery_partners_phone_key; Type: CONSTRAINT; Schema: zepto; Owner: postgres
--

ALTER TABLE ONLY zepto.delivery_partners
    ADD CONSTRAINT delivery_partners_phone_key UNIQUE (phone);


--
-- TOC entry 4962 (class 2606 OID 16885)
-- Name: delivery_partners delivery_partners_pkey; Type: CONSTRAINT; Schema: zepto; Owner: postgres
--

ALTER TABLE ONLY zepto.delivery_partners
    ADD CONSTRAINT delivery_partners_pkey PRIMARY KEY (partner_id);


--
-- TOC entry 4956 (class 2606 OID 16861)
-- Name: inventory inventory_pkey; Type: CONSTRAINT; Schema: zepto; Owner: postgres
--

ALTER TABLE ONLY zepto.inventory
    ADD CONSTRAINT inventory_pkey PRIMARY KEY (inventory_id);


--
-- TOC entry 4958 (class 2606 OID 16863)
-- Name: inventory inventory_store_id_product_id_key; Type: CONSTRAINT; Schema: zepto; Owner: postgres
--

ALTER TABLE ONLY zepto.inventory
    ADD CONSTRAINT inventory_store_id_product_id_key UNIQUE (store_id, product_id);


--
-- TOC entry 4972 (class 2606 OID 16928)
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: zepto; Owner: postgres
--

ALTER TABLE ONLY zepto.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (order_item_id);


--
-- TOC entry 4968 (class 2606 OID 16904)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: zepto; Owner: postgres
--

ALTER TABLE ONLY zepto.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);


--
-- TOC entry 4979 (class 2606 OID 16977)
-- Name: payments payments_order_id_key; Type: CONSTRAINT; Schema: zepto; Owner: postgres
--

ALTER TABLE ONLY zepto.payments
    ADD CONSTRAINT payments_order_id_key UNIQUE (order_id);


--
-- TOC entry 4981 (class 2606 OID 16975)
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: zepto; Owner: postgres
--

ALTER TABLE ONLY zepto.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (payment_id);


--
-- TOC entry 4984 (class 2606 OID 16996)
-- Name: product_reviews product_reviews_pkey; Type: CONSTRAINT; Schema: zepto; Owner: postgres
--

ALTER TABLE ONLY zepto.product_reviews
    ADD CONSTRAINT product_reviews_pkey PRIMARY KEY (review_id);


--
-- TOC entry 4953 (class 2606 OID 16847)
-- Name: products products_pkey; Type: CONSTRAINT; Schema: zepto; Owner: postgres
--

ALTER TABLE ONLY zepto.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);


--
-- TOC entry 4949 (class 2606 OID 16831)
-- Name: stores stores_contact_key; Type: CONSTRAINT; Schema: zepto; Owner: postgres
--

ALTER TABLE ONLY zepto.stores
    ADD CONSTRAINT stores_contact_key UNIQUE (contact);


--
-- TOC entry 4951 (class 2606 OID 16829)
-- Name: stores stores_pkey; Type: CONSTRAINT; Schema: zepto; Owner: postgres
--

ALTER TABLE ONLY zepto.stores
    ADD CONSTRAINT stores_pkey PRIMARY KEY (store_id);


--
-- TOC entry 4947 (class 1259 OID 17021)
-- Name: idx_customers_city; Type: INDEX; Schema: zepto; Owner: postgres
--

CREATE INDEX idx_customers_city ON zepto.customers USING btree (city);


--
-- TOC entry 4977 (class 1259 OID 17019)
-- Name: idx_deliv_partner; Type: INDEX; Schema: zepto; Owner: postgres
--

CREATE INDEX idx_deliv_partner ON zepto.deliveries USING btree (partner_id);


--
-- TOC entry 4954 (class 1259 OID 17018)
-- Name: idx_inv_store_prod; Type: INDEX; Schema: zepto; Owner: postgres
--

CREATE INDEX idx_inv_store_prod ON zepto.inventory USING btree (store_id, product_id);


--
-- TOC entry 4969 (class 1259 OID 17016)
-- Name: idx_order_items_ord; Type: INDEX; Schema: zepto; Owner: postgres
--

CREATE INDEX idx_order_items_ord ON zepto.order_items USING btree (order_id);


--
-- TOC entry 4970 (class 1259 OID 17017)
-- Name: idx_order_items_prod; Type: INDEX; Schema: zepto; Owner: postgres
--

CREATE INDEX idx_order_items_prod ON zepto.order_items USING btree (product_id);


--
-- TOC entry 4963 (class 1259 OID 17012)
-- Name: idx_orders_customer; Type: INDEX; Schema: zepto; Owner: postgres
--

CREATE INDEX idx_orders_customer ON zepto.orders USING btree (customer_id);


--
-- TOC entry 4964 (class 1259 OID 17014)
-- Name: idx_orders_date; Type: INDEX; Schema: zepto; Owner: postgres
--

CREATE INDEX idx_orders_date ON zepto.orders USING btree (order_date);


--
-- TOC entry 4965 (class 1259 OID 17015)
-- Name: idx_orders_status; Type: INDEX; Schema: zepto; Owner: postgres
--

CREATE INDEX idx_orders_status ON zepto.orders USING btree (status);


--
-- TOC entry 4966 (class 1259 OID 17013)
-- Name: idx_orders_store; Type: INDEX; Schema: zepto; Owner: postgres
--

CREATE INDEX idx_orders_store ON zepto.orders USING btree (store_id);


--
-- TOC entry 4982 (class 1259 OID 17020)
-- Name: idx_reviews_product; Type: INDEX; Schema: zepto; Owner: postgres
--

CREATE INDEX idx_reviews_product ON zepto.product_reviews USING btree (product_id);


--
-- TOC entry 4991 (class 2606 OID 16953)
-- Name: deliveries deliveries_order_id_fkey; Type: FK CONSTRAINT; Schema: zepto; Owner: postgres
--

ALTER TABLE ONLY zepto.deliveries
    ADD CONSTRAINT deliveries_order_id_fkey FOREIGN KEY (order_id) REFERENCES zepto.orders(order_id);


--
-- TOC entry 4992 (class 2606 OID 16958)
-- Name: deliveries deliveries_partner_id_fkey; Type: FK CONSTRAINT; Schema: zepto; Owner: postgres
--

ALTER TABLE ONLY zepto.deliveries
    ADD CONSTRAINT deliveries_partner_id_fkey FOREIGN KEY (partner_id) REFERENCES zepto.delivery_partners(partner_id);


--
-- TOC entry 4985 (class 2606 OID 16869)
-- Name: inventory inventory_product_id_fkey; Type: FK CONSTRAINT; Schema: zepto; Owner: postgres
--

ALTER TABLE ONLY zepto.inventory
    ADD CONSTRAINT inventory_product_id_fkey FOREIGN KEY (product_id) REFERENCES zepto.products(product_id);


--
-- TOC entry 4986 (class 2606 OID 16864)
-- Name: inventory inventory_store_id_fkey; Type: FK CONSTRAINT; Schema: zepto; Owner: postgres
--

ALTER TABLE ONLY zepto.inventory
    ADD CONSTRAINT inventory_store_id_fkey FOREIGN KEY (store_id) REFERENCES zepto.stores(store_id);


--
-- TOC entry 4989 (class 2606 OID 16929)
-- Name: order_items order_items_order_id_fkey; Type: FK CONSTRAINT; Schema: zepto; Owner: postgres
--

ALTER TABLE ONLY zepto.order_items
    ADD CONSTRAINT order_items_order_id_fkey FOREIGN KEY (order_id) REFERENCES zepto.orders(order_id) ON DELETE CASCADE;


--
-- TOC entry 4990 (class 2606 OID 16934)
-- Name: order_items order_items_product_id_fkey; Type: FK CONSTRAINT; Schema: zepto; Owner: postgres
--

ALTER TABLE ONLY zepto.order_items
    ADD CONSTRAINT order_items_product_id_fkey FOREIGN KEY (product_id) REFERENCES zepto.products(product_id);


--
-- TOC entry 4987 (class 2606 OID 16905)
-- Name: orders orders_customer_id_fkey; Type: FK CONSTRAINT; Schema: zepto; Owner: postgres
--

ALTER TABLE ONLY zepto.orders
    ADD CONSTRAINT orders_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES zepto.customers(customer_id);


--
-- TOC entry 4988 (class 2606 OID 16910)
-- Name: orders orders_store_id_fkey; Type: FK CONSTRAINT; Schema: zepto; Owner: postgres
--

ALTER TABLE ONLY zepto.orders
    ADD CONSTRAINT orders_store_id_fkey FOREIGN KEY (store_id) REFERENCES zepto.stores(store_id);


--
-- TOC entry 4993 (class 2606 OID 16978)
-- Name: payments payments_order_id_fkey; Type: FK CONSTRAINT; Schema: zepto; Owner: postgres
--

ALTER TABLE ONLY zepto.payments
    ADD CONSTRAINT payments_order_id_fkey FOREIGN KEY (order_id) REFERENCES zepto.orders(order_id);


--
-- TOC entry 4994 (class 2606 OID 17002)
-- Name: product_reviews product_reviews_customer_id_fkey; Type: FK CONSTRAINT; Schema: zepto; Owner: postgres
--

ALTER TABLE ONLY zepto.product_reviews
    ADD CONSTRAINT product_reviews_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES zepto.customers(customer_id);


--
-- TOC entry 4995 (class 2606 OID 17007)
-- Name: product_reviews product_reviews_order_id_fkey; Type: FK CONSTRAINT; Schema: zepto; Owner: postgres
--

ALTER TABLE ONLY zepto.product_reviews
    ADD CONSTRAINT product_reviews_order_id_fkey FOREIGN KEY (order_id) REFERENCES zepto.orders(order_id);


--
-- TOC entry 4996 (class 2606 OID 16997)
-- Name: product_reviews product_reviews_product_id_fkey; Type: FK CONSTRAINT; Schema: zepto; Owner: postgres
--

ALTER TABLE ONLY zepto.product_reviews
    ADD CONSTRAINT product_reviews_product_id_fkey FOREIGN KEY (product_id) REFERENCES zepto.products(product_id);


-- Completed on 2026-04-26 21:42:07

--
-- PostgreSQL database dump complete
--

\unrestrict gu6h8XwclMvmNFR6HrEx5MpSLstiTKo3vfqDmaUYSSz1fYewDLbqIRiT0ztIvmd

