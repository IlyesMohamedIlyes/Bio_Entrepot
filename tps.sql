/* TAIR KHADIDJA M1 BIOINFORMATIQUE */
/*########################## TP1 ##############################3*/
/*--------------------------------------------------------------*/
create user gene identified by gene;
grant all privileges to gene; 
create user labo identified by labo;
grant all privileges to labo; 

connect gene/gene
/*----------------------- la table gene ------------------------------*/
CREATE TABLE gene 
(id_gene Number(10),
organisme varchar(10),
annotation varchar(10),
reference varchar(40),
id_categorie Number(10),
CONSTRAINTS gene_key PRIMARY KEY (id_gene),
CONSTRAINTS gene_key1 FOREIGN KEY (id_categorie) REFERENCES categorie(id_cat));


/*----------------------- la table categorie ------------------------------*/ 
CREATE TABLE  categorie
(id_cat number(10),
nom_cat varchar(20),
CONSTRAINTS cate_key PRIMARY KEY (id_cat));

/*----------------------- la table proteine ------------------------------*/ 

CREATE TABLE prot 
( id_prot NUMBER (20),
nom varchar(20),
poids number(20),
longueur number (20),
reference varchar(20),
id_g number(20),
CONSTRAINTS prot_key PRIMARY KEY (id_prot),
CONSTRAINTS prot_key1 FOREIGN KEY (id_g) REFERENCES gene(id_gene));

/*--------------------------2eme base ---------------------------*/

connect labo/labo 
/*----------------------- la table region ------------------------------*/
create table region 
(code_reg Number(10),
ville varchar(20),
pays varchar(20),
CONSTRAINTS REG_key PRIMARY KEY (code_reg));

/*----------------------- la table laboratoire ------------------------------*/ 

create table labo
(id_lab number(10),
nom varchar(20),
acronyme varchar(20),
code_region number(20),
CONSTRAINTS lab_key PRIMARY KEY (id_lab),
CONSTRAINTS lab_key1 FOREIGN key (code_region) REFERENCES region(code_reg));



/*----------------------- la table experience ------------------------------*/
create table experience 
(id_exp number(10),
description varchar(10),
date_debut date,
duree number (20),
budget number(20),
id_labo number (20),
CONSTRAINTS exp_key PRIMARY KEY (id_exp),
CONSTRAINTS exp_key1 FOREIGN key (id_labo) REFERENCES labo(id_lab));


/*----------------------- la table gene ------------------------------*/
create table gene 
(id_g number (10),
nom char(10),
reference varchar (20),
constraints gen_key primary key (id_g));

/*----------------------- la table d'association concerne  ------------------------------*/ 
create table concerne
(id_exp number(10),
id_gen number(10),
CONSTRAINTS con_key PRIMARY KEY (id_exp,id_gen));


alter table categorie
modify (id_cat number(10),
nom_cat varchar(20));
/*-------------------------- les insertions-----------------------------------------------*/

insert into categorie(id_cat,nom_cat) 
values ('1','antioxidant');
insert into categorie(id_cat,nom_cat) 
values ('2','bondind');
insert into categorie(id_cat,nom_cat) 
values ('3','glutathione');
insert into categorie(id_cat,nom_cat) 
values ('4','glycine binding');
insert into categorie(id_cat,nom_cat) 
values ('5','amino acidebinding');

select * from categorie;


insert into region(code_reg,ville,pays) 
values ('1','constantine','Algerie');
insert into region(code_reg,ville,pays) 
values ('2','Vienne','Autriche');
insert into region(code_reg,ville,pays) 
values ('3','Amman','Jordanie');
insert into region(code_reg,ville,pays) 
values ('4','Lyon','France');

select * from region;

/*'u', 'U' - returning string in uppercase alpha characters

'l', 'L' - returning string in lowercase alpha characters

'a', 'A' - returning string in mixed case alpha characters

'x', 'X' - returning string in uppercase alpha-numeric characters

'p', 'P' - returning string in any printable characters*/

/*--------------------- les données aléatoire ------------------------------------*/
Declare 
nom char(20); id_gene number; 
begin 
     for i in 1..5000 loop
	     select dbms_random.string('p',20)into nom from dual;
		 select dbms_random.value(1,1000) into  id_gene from dual;
		 insert into prot values(i,nom,null,null,null, id_gene);
		 
	 end loop;
	 commit;
End;
/
Declare 
 organisme char(10); annotation char(10);reference char(10); id_categorie number; 
begin 
     for i in 1..1000 loop
	     select dbms_random.string('p',10)into organisme from dual;
		 select dbms_random.string('p',10)into annotation from dual;
		 select dbms_random.string('p',10)into reference from dual;
		 select dbms_random.value(1,5) into id_categorie from dual;
		 insert into gene values(i,organisme,annotation,reference,id_categorie);
		 
	 end loop;
	 commit;
	 
End;
/


Declare 
 nom char(10); acronyme char(10); id_region number; 
begin 
     for i in 1..50 loop
	     select dbms_random.string('p',10)into nom from dual;
		 select dbms_random.string('p',10)into acronyme from dual;
		 select dbms_random.value(1,4) into id_region from dual;
		 insert into labo values(i,nom,acronyme,id_region);
		 
	 end loop;
	 commit;
End;
/



Declare 
 description char(10); date_debut date; duree number(10); budget number(10);id_labo number(10);
begin 
     for i in 1..1000 loop
	     select dbms_random.string('p',10)into description from dual;
		 select TO_DATE(TRUNC( DBMS_RANDOM.value(TO_CHAR(date '2000-01-01','J'),TO_CHAR(SYSDATE,'J'))),'J') into date_debut from dual;
		 select dbms_random.value(10,100) into duree from dual;
		 select dbms_random.value(10,130) into budget from dual;
		 select dbms_random.value(1,50) into id_labo from dual;
		 insert into experience values(i,description,date_debut,duree,budget,id_labo);
		 
	 end loop;
	 commit;
End;
/

declare 
nom char(10); reference char(20);
 begin 
     for i in 1..100 loop
	     select dbms_random.string('p',10)into nom from dual;
		 select dbms_random.string('p',20)into reference from dual;
		 insert into gene values(i,nom,reference);
		 
	 end loop;
	 commit;
End;
/


/* ######################### TP2 (ENTREPOT DE DONNEE ###################*/


create user entrepot identified by entrepot;
grant all privileges to entrepot; 

connect entrepot/ entrepot
/*------------------creation des tables -------------------*/

create table Dregion 
(code_reg Number(10),
ville varchar(20),
pays varchar(20),
CONSTRAINTS REG_key PRIMARY KEY (code_reg));

create table times  
(id number(20),
jour Number(10),
mois number(20),
annee number(20),
CONSTRAINTS t2_key PRIMARY KEY (id));

CREATE TABLE  Dcategorie_gene
(id_cat number(10),
nom_cat varchar(20),
CONSTRAINTS cat_key PRIMARY KEY (id_cat));


CREATE TABLE  Frecherche
(
id number(20),
code_reg Number(10),
id_cat number(10),
nbr_exp number(10),
Budget number(20),
CONSTRAINTS F_key PRIMARY KEY (code_reg,id,id_cat),
constraint f_key2 foreign key (code_reg) REFERENCES Dregion(code_reg),
constraint f_key3 foreign key (id) REFERENCES times(id),
constraint f_key4 foreign key (id_cat) REFERENCES Dcategorie_gene(id_cat))
;

/*------------------ Alimentation de l'entrepot de donnée --------------------- */


Insert into Dregion(code_reg,ville,pays)
select code_reg,ville,pays 
from labo.region; 

Insert into Dcategorie_gene(id_cat,nom_cat)
select id_cat,nom_cat
from gene.categorie;



Declare 
jour Number(10);
mois number(20);
annee number(20);
begin 
     for i in 1..100 loop
		 select dbms_random.value(1,30) into jour from dual;
		 select dbms_random.value(1,12) into mois from dual;
		 select dbms_random.value(2001,2019) into annee from dual;

		 insert into times values(i,jour,mois,annee);
		 
	 end loop;
	 commit;
End;
/

/*--------------- Alimentation de la table des faits ------------------------*/



insert into Frecherche(code_reg,id,id_cat,nbr_exp,budget)  
select code_reg,id,id_cat,count(labo.experience.id_exp),sum(labo.experience.budget)
from times,labo.experience,labo.gene,labo.labo,labo.region,gene.categorie,gene.gene
where labo.experience.id_labo=labo.labo.id_lab and labo.labo.code_region=labo.region.code_reg 
and gene.categorie.id_cat=gene.gene.id_categorie and gene.gene.id_gene=labo.gene.id_g
group by (code_reg,id,id_cat);

commit;
/*------------- Interrogation de l'entrepot -----------------*/

/* requete 1 */

select D.code_reg,ville,pays ,nbr_exp
from Dregion D,Frecherche F 
where D.code_reg=F.code_reg
order by nbr_exp desc ; 

/* requete 2 */

select D.code_reg,ville,pays ,nbr_exp,budget
from Dregion D,Frecherche F 
where D.code_reg=F.code_reg
order by nbr_exp desc ;
/* requete 3 */

select D.id_cat,nom_cat,nbr_exp
from Dcategorie_gene D,Frecherche F 
where D.id_cat=F.id_cat
order by nbr_exp desc ;

/*-----------------------Agrégations---------------------------*/


/*---a--*/
/*un simple affichage y'a pas de sommes */
select C.id_cat,D.code_reg,count(nbr_exp)
from Dregion D,Frecherche F,Dcategorie_gene C
where D.code_reg=F.code_reg and F.id_cat=C.id_cat
group by (C.id_cat,F.code_reg);
/*--b--*/
/*somme par region et totale */
select C.id_cat,D.code_reg,count(nbr_exp)
from Dregion D,Frecherche F,Dcategorie_gene C
where D.code_reg=F.code_reg and F.id_cat=C.id_cat
group by rollup(C.id_cat,F.code_reg);

/*----c--*/
/*somme par categorie et region et totale */
select C.id_cat,D.code_reg,count(nbr_exp)
from Dregion D,Frecherche F,Dcategorie_gene C
where D.code_reg=F.code_reg and F.id_cat=C.id_cat
group by cube(C.id_cat,F.code_reg);

/*----d----*/
/*grouping pour indiquer sur quel champs on a calculer la somme */
select C.id_cat,D.code_reg,count(nbr_exp),grouping(C.id_cat) as categorie , grouping(D.code_reg) as region
from Dregion D,Frecherche F,Dcategorie_gene C
where D.code_reg=F.code_reg and F.id_cat=C.id_cat
group by cube(C.id_cat,F.code_reg);

/*----e---*/
/*grouping_id pour ajouter id pour chaque somme */
select C.id_cat,D.code_reg,count(nbr_exp),grouping_id(C.id_cat,D.code_reg)as grouping_id
from Dregion D,Frecherche F,Dcategorie_gene C
where D.code_reg=F.code_reg and F.id_cat=C.id_cat
group by cube(C.id_cat,F.code_reg);







