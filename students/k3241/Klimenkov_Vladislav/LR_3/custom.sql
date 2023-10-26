PGDMP                  	    {            session_database    16.0    16.0 ]    :           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            ;           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            <           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            =           1262    16421    session_database    DATABASE     �   CREATE DATABASE session_database WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';
     DROP DATABASE session_database;
                postgres    false            >           0    0    DATABASE session_database    COMMENT     8   COMMENT ON DATABASE session_database IS 'Сессия';
                   postgres    false    4925            �            1259    16578    attestations    TABLE     �  CREATE TABLE public.attestations (
    a_discipline_in_curricula_code integer NOT NULL,
    a_date date NOT NULL,
    a_student_record_book integer NOT NULL,
    a_attempt integer NOT NULL,
    a_semester integer NOT NULL,
    a_grade character varying(10) NOT NULL,
    a_teacher_id integer NOT NULL,
    CONSTRAINT attestations_a_attempt_check CHECK ((a_attempt >= 1)),
    CONSTRAINT attestations_a_grade_check CHECK (((a_grade)::text = ANY ((ARRAY['5'::character varying, '4'::character varying, '3'::character varying, '2'::character varying, 'Зачёт'::character varying, 'Незачёт'::character varying])::text[]))),
    CONSTRAINT attestations_a_semester_check CHECK ((a_semester >= 1))
);
     DROP TABLE public.attestations;
       public         heap    postgres    false            ?           0    0    TABLE attestations    COMMENT     @   COMMENT ON TABLE public.attestations IS 'Аттестация';
          public          postgres    false    230            �            1259    16463    auditoriums    TABLE     �   CREATE TABLE public.auditoriums (
    a_id integer NOT NULL,
    a_site_name character varying(50) NOT NULL,
    a_type character varying(50) NOT NULL,
    a_number integer NOT NULL,
    CONSTRAINT auditoriums_a_number_check CHECK ((a_number >= 0))
);
    DROP TABLE public.auditoriums;
       public         heap    postgres    false            @           0    0    TABLE auditoriums    COMMENT     =   COMMENT ON TABLE public.auditoriums IS 'Аудитории';
          public          postgres    false    222            �            1259    16488 	   curricula    TABLE     �   CREATE TABLE public.curricula (
    c_code integer NOT NULL,
    c_educational_program_code integer NOT NULL,
    c_admission_year date NOT NULL
);
    DROP TABLE public.curricula;
       public         heap    postgres    false            A           0    0    TABLE curricula    COMMENT     B   COMMENT ON TABLE public.curricula IS 'Учебные планы';
          public          postgres    false    224            �            1259    16453 
   directions    TABLE     �   CREATE TABLE public.directions (
    d_code integer NOT NULL,
    d_name character varying(50) NOT NULL,
    d_qualification character varying(100) NOT NULL
);
    DROP TABLE public.directions;
       public         heap    postgres    false            B           0    0    TABLE directions    COMMENT     @   COMMENT ON TABLE public.directions IS 'Направления';
          public          postgres    false    220            �            1259    16448    disciplines    TABLE     u  CREATE TABLE public.disciplines (
    d_code integer NOT NULL,
    d_name character varying(50) NOT NULL,
    d_hours integer NOT NULL,
    d_lecture_hours integer NOT NULL,
    d_practical_hours integer NOT NULL,
    d_laboratory_hours integer NOT NULL,
    CONSTRAINT disciplines_check CHECK ((((d_lecture_hours + d_practical_hours) + d_laboratory_hours) <= d_hours))
);
    DROP TABLE public.disciplines;
       public         heap    postgres    false            C           0    0    TABLE disciplines    COMMENT     ?   COMMENT ON TABLE public.disciplines IS 'Дисциплины';
          public          postgres    false    219            �            1259    16548    disciplines_in_curricula    TABLE       CREATE TABLE public.disciplines_in_curricula (
    dic_code integer NOT NULL,
    dic_discipline_code integer NOT NULL,
    dic_curriculum_code integer NOT NULL,
    dic_semester integer NOT NULL,
    CONSTRAINT disciplines_in_curricula_dic_semester_check CHECK ((dic_semester >= 1))
);
 ,   DROP TABLE public.disciplines_in_curricula;
       public         heap    postgres    false            D           0    0    TABLE disciplines_in_curricula    COMMENT     k   COMMENT ON TABLE public.disciplines_in_curricula IS 'Дисциплины в учебных планах';
          public          postgres    false    228            �            1259    16458 	   divisions    TABLE     k   CREATE TABLE public.divisions (
    d_code integer NOT NULL,
    d_name character varying(100) NOT NULL
);
    DROP TABLE public.divisions;
       public         heap    postgres    false            E           0    0    TABLE divisions    COMMENT     C   COMMENT ON TABLE public.divisions IS 'Подразделения';
          public          postgres    false    221            �            1259    16563    divisions_on_sites    TABLE     �   CREATE TABLE public.divisions_on_sites (
    dos_site_name character varying(100) NOT NULL,
    dos_division_code integer NOT NULL
);
 &   DROP TABLE public.divisions_on_sites;
       public         heap    postgres    false            F           0    0    TABLE divisions_on_sites    COMMENT     d   COMMENT ON TABLE public.divisions_on_sites IS 'Подразделения на площадках';
          public          postgres    false    229            �            1259    16473    educational_programmes    TABLE     �  CREATE TABLE public.educational_programmes (
    ep_code integer NOT NULL,
    ep_name character varying(100) NOT NULL,
    ep_division_code integer NOT NULL,
    ep_direction_code integer NOT NULL,
    ep_format character varying(50) NOT NULL,
    CONSTRAINT educational_programmes_ep_format_check CHECK (((ep_format)::text = ANY (ARRAY[('Очно'::character varying)::text, ('Очно-заочно'::character varying)::text, ('Заочно'::character varying)::text])))
);
 *   DROP TABLE public.educational_programmes;
       public         heap    postgres    false            G           0    0    TABLE educational_programmes    COMMENT     g   COMMENT ON TABLE public.educational_programmes IS 'Образовательные программы';
          public          postgres    false    223            �            1259    16508    scholarship_receipts    TABLE       CREATE TABLE public.scholarship_receipts (
    sr_scholarship_id integer NOT NULL,
    sr_student_record_book integer NOT NULL,
    sr_date date NOT NULL,
    sr_sum integer NOT NULL,
    CONSTRAINT scholarship_receipts_sr_sum_check CHECK ((sr_sum >= 0))
);
 (   DROP TABLE public.scholarship_receipts;
       public         heap    postgres    false            H           0    0    TABLE scholarship_receipts    COMMENT     Y   COMMENT ON TABLE public.scholarship_receipts IS 'Получение стипендии';
          public          postgres    false    226            �            1259    16422    scholarships    TABLE     �   CREATE TABLE public.scholarships (
    s_id integer NOT NULL,
    s_type character varying(100) NOT NULL,
    s_name character varying(100) NOT NULL
);
     DROP TABLE public.scholarships;
       public         heap    postgres    false            I           0    0    TABLE scholarships    COMMENT     >   COMMENT ON TABLE public.scholarships IS 'Стипендии';
          public          postgres    false    215            �            1259    16598    session_schedule    TABLE     �   CREATE TABLE public.session_schedule (
    ss_study_group_code integer NOT NULL,
    ss_discipline_in_curriculum_code integer NOT NULL,
    ss_date date NOT NULL,
    ss_auditorium_id integer,
    ss_teacher_id integer NOT NULL
);
 $   DROP TABLE public.session_schedule;
       public         heap    postgres    false            J           0    0    TABLE session_schedule    COMMENT     Q   COMMENT ON TABLE public.session_schedule IS 'Расписание сессии';
          public          postgres    false    231            �            1259    16438    sites    TABLE     y   CREATE TABLE public.sites (
    s_name character varying(100) NOT NULL,
    s_address character varying(100) NOT NULL
);
    DROP TABLE public.sites;
       public         heap    postgres    false            K           0    0    TABLE sites    COMMENT     H   COMMENT ON TABLE public.sites IS 'Площадки института';
          public          postgres    false    217            �            1259    16433    students    TABLE     $  CREATE TABLE public.students (
    s_record_book integer NOT NULL,
    s_first_name character varying(50) NOT NULL,
    s_last_name character varying(50) NOT NULL,
    s_patronymic character varying(50),
    s_course integer,
    CONSTRAINT students_s_course_check CHECK ((s_course >= 1))
);
    DROP TABLE public.students;
       public         heap    postgres    false            L           0    0    TABLE students    COMMENT     8   COMMENT ON TABLE public.students IS 'Студенты';
          public          postgres    false    216            �            1259    16533    students_in_study_groups    TABLE     �   CREATE TABLE public.students_in_study_groups (
    sisg_student_record_book integer NOT NULL,
    sisg_study_group_code integer NOT NULL,
    sisg_from date NOT NULL,
    sisg_to date
);
 ,   DROP TABLE public.students_in_study_groups;
       public         heap    postgres    false            M           0    0    TABLE students_in_study_groups    COMMENT     i   COMMENT ON TABLE public.students_in_study_groups IS 'Студенты в учебных группах';
          public          postgres    false    227            �            1259    16498    study_groups    TABLE     �   CREATE TABLE public.study_groups (
    sg_code integer NOT NULL,
    sg_number character varying(50) NOT NULL,
    sg_curriculum_code integer NOT NULL,
    sg_from date NOT NULL,
    sg_to date
);
     DROP TABLE public.study_groups;
       public         heap    postgres    false            N           0    0    TABLE study_groups    COMMENT     G   COMMENT ON TABLE public.study_groups IS 'Учебные группы';
          public          postgres    false    225            �            1259    16443    teachers    TABLE     �   CREATE TABLE public.teachers (
    t_id integer NOT NULL,
    t_first_name character varying(50) NOT NULL,
    t_last_name character varying(50) NOT NULL,
    t_patronymic character varying(50),
    t_position character varying(100) NOT NULL
);
    DROP TABLE public.teachers;
       public         heap    postgres    false            O           0    0    TABLE teachers    COMMENT     B   COMMENT ON TABLE public.teachers IS 'Преподаватели';
          public          postgres    false    218            6          0    16578    attestations 
   TABLE DATA           �   COPY public.attestations (a_discipline_in_curricula_code, a_date, a_student_record_book, a_attempt, a_semester, a_grade, a_teacher_id) FROM stdin;
    public          postgres    false    230   �}       .          0    16463    auditoriums 
   TABLE DATA           J   COPY public.auditoriums (a_id, a_site_name, a_type, a_number) FROM stdin;
    public          postgres    false    222   K~       0          0    16488 	   curricula 
   TABLE DATA           Y   COPY public.curricula (c_code, c_educational_program_code, c_admission_year) FROM stdin;
    public          postgres    false    224   !       ,          0    16453 
   directions 
   TABLE DATA           E   COPY public.directions (d_code, d_name, d_qualification) FROM stdin;
    public          postgres    false    220   m       +          0    16448    disciplines 
   TABLE DATA           v   COPY public.disciplines (d_code, d_name, d_hours, d_lecture_hours, d_practical_hours, d_laboratory_hours) FROM stdin;
    public          postgres    false    219   �       4          0    16548    disciplines_in_curricula 
   TABLE DATA           t   COPY public.disciplines_in_curricula (dic_code, dic_discipline_code, dic_curriculum_code, dic_semester) FROM stdin;
    public          postgres    false    228   �       -          0    16458 	   divisions 
   TABLE DATA           3   COPY public.divisions (d_code, d_name) FROM stdin;
    public          postgres    false    221   ?�       5          0    16563    divisions_on_sites 
   TABLE DATA           N   COPY public.divisions_on_sites (dos_site_name, dos_division_code) FROM stdin;
    public          postgres    false    229   ��       /          0    16473    educational_programmes 
   TABLE DATA           r   COPY public.educational_programmes (ep_code, ep_name, ep_division_code, ep_direction_code, ep_format) FROM stdin;
    public          postgres    false    223   ��       2          0    16508    scholarship_receipts 
   TABLE DATA           j   COPY public.scholarship_receipts (sr_scholarship_id, sr_student_record_book, sr_date, sr_sum) FROM stdin;
    public          postgres    false    226   P�       '          0    16422    scholarships 
   TABLE DATA           <   COPY public.scholarships (s_id, s_type, s_name) FROM stdin;
    public          postgres    false    215   ��       7          0    16598    session_schedule 
   TABLE DATA           �   COPY public.session_schedule (ss_study_group_code, ss_discipline_in_curriculum_code, ss_date, ss_auditorium_id, ss_teacher_id) FROM stdin;
    public          postgres    false    231   ��       )          0    16438    sites 
   TABLE DATA           2   COPY public.sites (s_name, s_address) FROM stdin;
    public          postgres    false    217   �       (          0    16433    students 
   TABLE DATA           d   COPY public.students (s_record_book, s_first_name, s_last_name, s_patronymic, s_course) FROM stdin;
    public          postgres    false    216   �       3          0    16533    students_in_study_groups 
   TABLE DATA           w   COPY public.students_in_study_groups (sisg_student_record_book, sisg_study_group_code, sisg_from, sisg_to) FROM stdin;
    public          postgres    false    227   (�       1          0    16498    study_groups 
   TABLE DATA           ^   COPY public.study_groups (sg_code, sg_number, sg_curriculum_code, sg_from, sg_to) FROM stdin;
    public          postgres    false    225   ��       *          0    16443    teachers 
   TABLE DATA           ]   COPY public.teachers (t_id, t_first_name, t_last_name, t_patronymic, t_position) FROM stdin;
    public          postgres    false    218   �       �           2606    16582    attestations attestations_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.attestations
    ADD CONSTRAINT attestations_pkey PRIMARY KEY (a_discipline_in_curricula_code, a_date);
 H   ALTER TABLE ONLY public.attestations DROP CONSTRAINT attestations_pkey;
       public            postgres    false    230    230            q           2606    16467    auditoriums auditoriums_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.auditoriums
    ADD CONSTRAINT auditoriums_pkey PRIMARY KEY (a_id);
 F   ALTER TABLE ONLY public.auditoriums DROP CONSTRAINT auditoriums_pkey;
       public            postgres    false    222            u           2606    16492    curricula curricula_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.curricula
    ADD CONSTRAINT curricula_pkey PRIMARY KEY (c_code);
 B   ALTER TABLE ONLY public.curricula DROP CONSTRAINT curricula_pkey;
       public            postgres    false    224            m           2606    16457    directions directions_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.directions
    ADD CONSTRAINT directions_pkey PRIMARY KEY (d_code);
 D   ALTER TABLE ONLY public.directions DROP CONSTRAINT directions_pkey;
       public            postgres    false    220            }           2606    16552 6   disciplines_in_curricula disciplines_in_curricula_pkey 
   CONSTRAINT     z   ALTER TABLE ONLY public.disciplines_in_curricula
    ADD CONSTRAINT disciplines_in_curricula_pkey PRIMARY KEY (dic_code);
 `   ALTER TABLE ONLY public.disciplines_in_curricula DROP CONSTRAINT disciplines_in_curricula_pkey;
       public            postgres    false    228            k           2606    16452    disciplines disciplines_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.disciplines
    ADD CONSTRAINT disciplines_pkey PRIMARY KEY (d_code);
 F   ALTER TABLE ONLY public.disciplines DROP CONSTRAINT disciplines_pkey;
       public            postgres    false    219                       2606    16567 *   divisions_on_sites divisions_on_sites_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.divisions_on_sites
    ADD CONSTRAINT divisions_on_sites_pkey PRIMARY KEY (dos_site_name, dos_division_code);
 T   ALTER TABLE ONLY public.divisions_on_sites DROP CONSTRAINT divisions_on_sites_pkey;
       public            postgres    false    229    229            o           2606    16462    divisions divisions_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.divisions
    ADD CONSTRAINT divisions_pkey PRIMARY KEY (d_code);
 B   ALTER TABLE ONLY public.divisions DROP CONSTRAINT divisions_pkey;
       public            postgres    false    221            s           2606    16477 2   educational_programmes educational_programmes_pkey 
   CONSTRAINT     u   ALTER TABLE ONLY public.educational_programmes
    ADD CONSTRAINT educational_programmes_pkey PRIMARY KEY (ep_code);
 \   ALTER TABLE ONLY public.educational_programmes DROP CONSTRAINT educational_programmes_pkey;
       public            postgres    false    223            y           2606    16512 .   scholarship_receipts scholarship_receipts_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.scholarship_receipts
    ADD CONSTRAINT scholarship_receipts_pkey PRIMARY KEY (sr_scholarship_id, sr_student_record_book, sr_date);
 X   ALTER TABLE ONLY public.scholarship_receipts DROP CONSTRAINT scholarship_receipts_pkey;
       public            postgres    false    226    226    226            c           2606    16426    scholarships scholarships_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.scholarships
    ADD CONSTRAINT scholarships_pkey PRIMARY KEY (s_id);
 H   ALTER TABLE ONLY public.scholarships DROP CONSTRAINT scholarships_pkey;
       public            postgres    false    215            �           2606    16602 &   session_schedule session_schedule_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.session_schedule
    ADD CONSTRAINT session_schedule_pkey PRIMARY KEY (ss_study_group_code, ss_discipline_in_curriculum_code, ss_date);
 P   ALTER TABLE ONLY public.session_schedule DROP CONSTRAINT session_schedule_pkey;
       public            postgres    false    231    231    231            g           2606    16442    sites sites_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.sites
    ADD CONSTRAINT sites_pkey PRIMARY KEY (s_name);
 :   ALTER TABLE ONLY public.sites DROP CONSTRAINT sites_pkey;
       public            postgres    false    217            {           2606    16537 6   students_in_study_groups students_in_study_groups_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.students_in_study_groups
    ADD CONSTRAINT students_in_study_groups_pkey PRIMARY KEY (sisg_student_record_book, sisg_study_group_code);
 `   ALTER TABLE ONLY public.students_in_study_groups DROP CONSTRAINT students_in_study_groups_pkey;
       public            postgres    false    227    227            e           2606    16437    students students_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_pkey PRIMARY KEY (s_record_book);
 @   ALTER TABLE ONLY public.students DROP CONSTRAINT students_pkey;
       public            postgres    false    216            w           2606    16502    study_groups study_groups_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.study_groups
    ADD CONSTRAINT study_groups_pkey PRIMARY KEY (sg_code);
 H   ALTER TABLE ONLY public.study_groups DROP CONSTRAINT study_groups_pkey;
       public            postgres    false    225            i           2606    16447    teachers teachers_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.teachers
    ADD CONSTRAINT teachers_pkey PRIMARY KEY (t_id);
 @   ALTER TABLE ONLY public.teachers DROP CONSTRAINT teachers_pkey;
       public            postgres    false    218            �           2606    16583 =   attestations attestations_a_discipline_in_curricula_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.attestations
    ADD CONSTRAINT attestations_a_discipline_in_curricula_code_fkey FOREIGN KEY (a_discipline_in_curricula_code) REFERENCES public.disciplines_in_curricula(dic_code);
 g   ALTER TABLE ONLY public.attestations DROP CONSTRAINT attestations_a_discipline_in_curricula_code_fkey;
       public          postgres    false    230    228    4733            �           2606    16588 4   attestations attestations_a_student_record_book_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.attestations
    ADD CONSTRAINT attestations_a_student_record_book_fkey FOREIGN KEY (a_student_record_book) REFERENCES public.students(s_record_book);
 ^   ALTER TABLE ONLY public.attestations DROP CONSTRAINT attestations_a_student_record_book_fkey;
       public          postgres    false    230    4709    216            �           2606    16593 +   attestations attestations_a_teacher_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.attestations
    ADD CONSTRAINT attestations_a_teacher_id_fkey FOREIGN KEY (a_teacher_id) REFERENCES public.teachers(t_id);
 U   ALTER TABLE ONLY public.attestations DROP CONSTRAINT attestations_a_teacher_id_fkey;
       public          postgres    false    218    4713    230            �           2606    16468 (   auditoriums auditoriums_a_site_name_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.auditoriums
    ADD CONSTRAINT auditoriums_a_site_name_fkey FOREIGN KEY (a_site_name) REFERENCES public.sites(s_name);
 R   ALTER TABLE ONLY public.auditoriums DROP CONSTRAINT auditoriums_a_site_name_fkey;
       public          postgres    false    217    4711    222            �           2606    16493 3   curricula curricula_c_educational_program_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.curricula
    ADD CONSTRAINT curricula_c_educational_program_code_fkey FOREIGN KEY (c_educational_program_code) REFERENCES public.educational_programmes(ep_code);
 ]   ALTER TABLE ONLY public.curricula DROP CONSTRAINT curricula_c_educational_program_code_fkey;
       public          postgres    false    4723    224    223            �           2606    16558 J   disciplines_in_curricula disciplines_in_curricula_dic_curriculum_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.disciplines_in_curricula
    ADD CONSTRAINT disciplines_in_curricula_dic_curriculum_code_fkey FOREIGN KEY (dic_curriculum_code) REFERENCES public.curricula(c_code);
 t   ALTER TABLE ONLY public.disciplines_in_curricula DROP CONSTRAINT disciplines_in_curricula_dic_curriculum_code_fkey;
       public          postgres    false    228    4725    224            �           2606    16553 J   disciplines_in_curricula disciplines_in_curricula_dic_discipline_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.disciplines_in_curricula
    ADD CONSTRAINT disciplines_in_curricula_dic_discipline_code_fkey FOREIGN KEY (dic_discipline_code) REFERENCES public.disciplines(d_code);
 t   ALTER TABLE ONLY public.disciplines_in_curricula DROP CONSTRAINT disciplines_in_curricula_dic_discipline_code_fkey;
       public          postgres    false    219    4715    228            �           2606    16573 <   divisions_on_sites divisions_on_sites_dos_division_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.divisions_on_sites
    ADD CONSTRAINT divisions_on_sites_dos_division_code_fkey FOREIGN KEY (dos_division_code) REFERENCES public.divisions(d_code);
 f   ALTER TABLE ONLY public.divisions_on_sites DROP CONSTRAINT divisions_on_sites_dos_division_code_fkey;
       public          postgres    false    229    4719    221            �           2606    16568 8   divisions_on_sites divisions_on_sites_dos_site_name_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.divisions_on_sites
    ADD CONSTRAINT divisions_on_sites_dos_site_name_fkey FOREIGN KEY (dos_site_name) REFERENCES public.sites(s_name);
 b   ALTER TABLE ONLY public.divisions_on_sites DROP CONSTRAINT divisions_on_sites_dos_site_name_fkey;
       public          postgres    false    4711    229    217            �           2606    16483 D   educational_programmes educational_programmes_ep_direction_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.educational_programmes
    ADD CONSTRAINT educational_programmes_ep_direction_code_fkey FOREIGN KEY (ep_direction_code) REFERENCES public.directions(d_code);
 n   ALTER TABLE ONLY public.educational_programmes DROP CONSTRAINT educational_programmes_ep_direction_code_fkey;
       public          postgres    false    220    223    4717            �           2606    16478 C   educational_programmes educational_programmes_ep_division_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.educational_programmes
    ADD CONSTRAINT educational_programmes_ep_division_code_fkey FOREIGN KEY (ep_division_code) REFERENCES public.divisions(d_code);
 m   ALTER TABLE ONLY public.educational_programmes DROP CONSTRAINT educational_programmes_ep_division_code_fkey;
       public          postgres    false    223    221    4719            �           2606    16513 @   scholarship_receipts scholarship_receipts_sr_scholarship_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.scholarship_receipts
    ADD CONSTRAINT scholarship_receipts_sr_scholarship_id_fkey FOREIGN KEY (sr_scholarship_id) REFERENCES public.scholarships(s_id);
 j   ALTER TABLE ONLY public.scholarship_receipts DROP CONSTRAINT scholarship_receipts_sr_scholarship_id_fkey;
       public          postgres    false    226    215    4707            �           2606    16518 E   scholarship_receipts scholarship_receipts_sr_student_record_book_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.scholarship_receipts
    ADD CONSTRAINT scholarship_receipts_sr_student_record_book_fkey FOREIGN KEY (sr_student_record_book) REFERENCES public.students(s_record_book);
 o   ALTER TABLE ONLY public.scholarship_receipts DROP CONSTRAINT scholarship_receipts_sr_student_record_book_fkey;
       public          postgres    false    4709    226    216            �           2606    16613 7   session_schedule session_schedule_ss_auditorium_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.session_schedule
    ADD CONSTRAINT session_schedule_ss_auditorium_id_fkey FOREIGN KEY (ss_auditorium_id) REFERENCES public.auditoriums(a_id);
 a   ALTER TABLE ONLY public.session_schedule DROP CONSTRAINT session_schedule_ss_auditorium_id_fkey;
       public          postgres    false    231    222    4721            �           2606    16608 G   session_schedule session_schedule_ss_discipline_in_curriculum_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.session_schedule
    ADD CONSTRAINT session_schedule_ss_discipline_in_curriculum_code_fkey FOREIGN KEY (ss_discipline_in_curriculum_code) REFERENCES public.disciplines_in_curricula(dic_code);
 q   ALTER TABLE ONLY public.session_schedule DROP CONSTRAINT session_schedule_ss_discipline_in_curriculum_code_fkey;
       public          postgres    false    231    228    4733            �           2606    16603 :   session_schedule session_schedule_ss_study_group_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.session_schedule
    ADD CONSTRAINT session_schedule_ss_study_group_code_fkey FOREIGN KEY (ss_study_group_code) REFERENCES public.study_groups(sg_code);
 d   ALTER TABLE ONLY public.session_schedule DROP CONSTRAINT session_schedule_ss_study_group_code_fkey;
       public          postgres    false    4727    225    231            �           2606    16618 4   session_schedule session_schedule_ss_teacher_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.session_schedule
    ADD CONSTRAINT session_schedule_ss_teacher_id_fkey FOREIGN KEY (ss_teacher_id) REFERENCES public.teachers(t_id);
 ^   ALTER TABLE ONLY public.session_schedule DROP CONSTRAINT session_schedule_ss_teacher_id_fkey;
       public          postgres    false    218    231    4713            �           2606    16538 O   students_in_study_groups students_in_study_groups_sisg_student_record_book_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.students_in_study_groups
    ADD CONSTRAINT students_in_study_groups_sisg_student_record_book_fkey FOREIGN KEY (sisg_student_record_book) REFERENCES public.students(s_record_book);
 y   ALTER TABLE ONLY public.students_in_study_groups DROP CONSTRAINT students_in_study_groups_sisg_student_record_book_fkey;
       public          postgres    false    216    227    4709            �           2606    16543 L   students_in_study_groups students_in_study_groups_sisg_study_group_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.students_in_study_groups
    ADD CONSTRAINT students_in_study_groups_sisg_study_group_code_fkey FOREIGN KEY (sisg_study_group_code) REFERENCES public.study_groups(sg_code);
 v   ALTER TABLE ONLY public.students_in_study_groups DROP CONSTRAINT students_in_study_groups_sisg_study_group_code_fkey;
       public          postgres    false    227    4727    225            �           2606    16503 1   study_groups study_groups_sg_curriculum_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.study_groups
    ADD CONSTRAINT study_groups_sg_curriculum_code_fkey FOREIGN KEY (sg_curriculum_code) REFERENCES public.curricula(c_code);
 [   ALTER TABLE ONLY public.study_groups DROP CONSTRAINT study_groups_sg_curriculum_code_fkey;
       public          postgres    false    224    225    4725            6   Y   x�Uͻ�@�vI���.���.'�=[�����0 MVV.V��"
ۺ��K�Ϲ��+����!%�Gsz��,��g�?���3�{      .   �   x�uO��0��)2"�	��@��D���&��pވ{��Y�u�>�\*�������]�'zw
'2>ք[��
^4jn�J����6Åt@�d7����
�A�#�i9���L\��3�I���AZ����c�����o�y�%������j��\�H^,mj���e� R���?&s�#�����      0   <   x�M��	  �wҋ��x`/�_�Q�yM{�!޵{.#��e�|W��S�kfU]t��      ,   �   x�}�1�0Eg�9Pn�aP�]: 66V��(%jڜ��F�D�ap�<?���NϘ,�ń�V���!�F=��5������g�ך���̈́����A�$��Z�_5mW��D���<o��j��2*���Fm�r\Y�f7Ƙ/�u��      +   �   x�%�I�0E��)z��Mӻp� �X�e��
T���g����l�9���w9� �J�����ၼ�k
a��!�Ɋg~����K�@6�ɧD]$�`�u	��kѭw�=�ҫ��(����;�(Dk|�bK|���-�y�I�����/<>��:�5!tM P�f�g�Y����xϠ!3�I�:���7P!W��KX�\c~���      4   A   x�ɹ� ����������o�Ch���!$�f�[�n)�Sފ�X�A�=f�X�      -   �   x�����0D�q� �O9�8��3P�28���0�q�[Z���]�*\��/FZ1,^pRS8I��9鐐)e<�ѫm�}AZr.F�p�f���L�Y3����F�td�)��o�3�'"RL|�!׋ȑ3���NȒ�K'<�M*��z�;2})�z��M�x�_)��~�c      5   {   x�M�;�0Dk�)|�H|����r�PPP�ZA���o��4��̾��΋X��A`!��ʱ�'��s9Hg����FQCe	ng��\���Y=?bk�:����R{Y<k]Ȯ̊Onc}gf_$eZ      /   �   x�}�[
�0��dY�4�?�����iq*~��Z[������kĪ%���Ɍ�(�
;丠�ZIQIxY�E�����\8���6xV��\�p�Hjie��v���S�
�Ԅ�-��$���~�� �?�ʷJ�>)�bV-�c���h��?j���@1'����y��MGZ�;0}�      2   =   x�Eɱ�0����II0�K��#vW��%��)����I2��}A�J��nx��� #w:      '   �   x��RI
�@<g^�(���ǘ(*((x� o��1F�	���G֌ňHHH���k���D)��@K�o!bQ��2�`pvP#�*4R�	���1�X�m3��"���*��H���#$���nK�ذP ����^X'w/>Ъ�Qʈ�~��f�&�U����ɞ��݆(�F#�a����f��W��TE�U��%�G�e*�Ǥ��\�k�)��l�����%>��a�6\2ի+������      7   5   x�M�� ��n.sN�����f^Z�J�o��h$�W�����|����      )   �   x��QKn�0]�S� I�@�]z�$��k��m�4(I�s����)�J ܍�y3���'X�Q��s+th�j�C�e��p>�l)F"�*�xCA�sO�pk�GBE9���4Sءa�D�D�_$�	ni��yf|[f��4�E�a�S�Y��G���jQ��,�E�A�n}G�7�LgC�N���ƞeC�f�`c����╣���ù.ĘٿqEjL���D)���t      (   7  x�m�MN�0���a�C��I!�X �H� U]���FJ�&gx�3�C+`�(��{��'�:g��6��"�;�ІF���ѠKz7��u/��Ό�V`��zF��=*�<����.�4�h�xe5����\��eBNle�K�d�|����'z�:�q�RӉ�Z��n�zK����I��(ȑ���k�]heU�!װ!�������9�f��^gZk�^���"'�:·��uNZ���kM��sN���Y<��3g���s�x��b�K#���l�tJ9}��,�7�1<�y��Ohy{%���Rg�      3   Z   x�u��	�0��.-�l��.��&�-�Cp�@�nb�`G��ʿ�5	�����[7gk�`���N^7��ʅ	��+�����d��x��=#�XL5�      1   D   x�3�t673��4�4202�50"���2�t211ʂ�P�\����f��`A�<T)W� kc�      *   �   x���Kn�@D�3��H	�6$A2D�&
A�8���`s����m$6Vv�t��L62��l�:�Q�C�%���]�4���%.4
Vd��nd=�%�!�s�%��DR�?�\j���r�R��Z��l�Pt,�DO>m�B쏣~���n�zfr�3r�"N$*"G7��|Pf��D�b?�7���뫵1h���:� �o�WE�yj%Q0o������i�T1��[]�.W�q�!���~6���bRbb     