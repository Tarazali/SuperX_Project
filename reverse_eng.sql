
CREATE TABLE public.dim_date (
                date_id DATE NOT NULL,
                year INTEGER NOT NULL,
                quarter INTEGER NOT NULL,
                month INTEGER NOT NULL,
                day INTEGER NOT NULL,
                CONSTRAINT dim_date_pk PRIMARY KEY (date_id)
);


CREATE SEQUENCE public.dim_material_material_id_seq;

CREATE TABLE public.dim_material (
                material_id INTEGER NOT NULL DEFAULT nextval('public.dim_material_material_id_seq'),
                type VARCHAR(10485760),
                name VARCHAR(10485760),
                description VARCHAR(10485760),
                hour_per_machine VARCHAR NOT NULL,
                employee_hour VARCHAR NOT NULL,
                ean VARCHAR(10485760),
                CONSTRAINT materials_pkey PRIMARY KEY (material_id)
);


ALTER SEQUENCE public.dim_material_material_id_seq OWNED BY public.dim_material.material_id;

CREATE SEQUENCE public.machines_id_seq;

CREATE TABLE public.dim_machine (
                machine_id INTEGER NOT NULL DEFAULT nextval('public.machines_id_seq'),
                type_id INTEGER NOT NULL,
                name VARCHAR NOT NULL,
                purchase_price VARCHAR NOT NULL,
                cost_per_hour VARCHAR NOT NULL,
                state VARCHAR(10485760) DEFAULT 'active'::character varying,
                CONSTRAINT machines_pkey PRIMARY KEY (machine_id)
);


ALTER SEQUENCE public.machines_id_seq OWNED BY public.dim_machine.machine_id;

CREATE INDEX index_machines_on_machine_type_id
 ON public.dim_machine USING BTREE
 ( type_id );

CREATE SEQUENCE public.fact_production_orders_id_seq;

CREATE TABLE public.fact_production_orders (
                id INTEGER NOT NULL DEFAULT nextval('public.fact_production_orders_id_seq'),
                machine_id INTEGER NOT NULL,
                material_id INTEGER NOT NULL,
                date_id DATE NOT NULL,
                quantity_produced BIGINT,
                machine_hours DOUBLE PRECISION,
                employee_hours DOUBLE PRECISION,
                machine_costs REAL NOT NULL,
                CONSTRAINT production_orders_pkey PRIMARY KEY (id, machine_id, material_id, date_id)
);


ALTER SEQUENCE public.fact_production_orders_id_seq OWNED BY public.fact_production_orders.id;

CREATE INDEX index_production_orders_on_material_id
 ON public.fact_production_orders USING BTREE
 ( material_id );

ALTER TABLE public.fact_production_orders ADD CONSTRAINT dim_date_fact_production_orders_fk
FOREIGN KEY (date_id)
REFERENCES public.dim_date (date_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.fact_production_orders ADD CONSTRAINT fk_rails_ea2d52328e
FOREIGN KEY (material_id)
REFERENCES public.dim_material (material_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.fact_production_orders ADD CONSTRAINT fk_rails_36ca093c85
FOREIGN KEY (machine_id)
REFERENCES public.dim_machine (machine_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
