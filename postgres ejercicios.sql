--1
select a.customerkey,b.firstname,b.lastname,sum(salesamount) 
from factinternetsales a
inner join dimcustomer b using (customerkey)
group by a.customerkey,b.firstname,b.lastname
order by customerkey;


--2
select a.customerkey,sum(salesamount),b.calendaryear 
from factinternetsales a
inner join dimdate b on a.duedatekey = b.datekey
where(b.calendaryear >= 2005 and b.calendaryear <= 2008)
group by b.calendaryear,a.customerkey
order by b.calendaryear ,a.customerkey;


--3
select d.englishproductcategoryname as "Categoria",  c.englishproductsubcategoryname as "Sub-Categoria", b.englishproductname as "Producto",sum(salesamount) as "Total"
from factinternetsales a
inner join dimproduct b using (productkey)
inner join dimproductsubcategory c using(productsubcategorykey)
inner join dimproductcategory d using(productcategorykey)
group by cube(d.englishproductcategoryname,c.englishproductsubcategoryname),b.englishproductname
order by sum(salesamount),c.englishproductsubcategoryname,b.englishproductname ASC;


--4
select  b.englishproductname as "Producto", count(salesordernumber) as "Cantidad de Ventas", SUM(freight) as "Precio de Envio",b.productsubcategorykey as "Sub - Categoria"
from factinternetsales a
inner join dimproduct b using (productkey)
group by b.productsubcategorykey, b.englishproductname
order by b.englishproductname,count(salesordernumber),SUM(freight) ASC;



--5
select b.englishproductname, SUM(salesamount)
from factinternetsales a
inner join dimproduct b using (productkey)
where b.englishproductname like 'A%'
group by b.englishproductname
having SUM(salesamount::numeric) < 5000
order by SUM(salesamount) ASC;


--6
select sum(salesamount)as "Total", b.salesterritorycountry as "Pais"
from factinternetsales a
inner join dimsalesterritory b using (salesterritorykey)
group by b.salesterritorycountry
order by b.salesterritorycountry;



--7
select b.englishproductname, c.calendaryear, sum(salesamount)
from factinternetsales a
inner join dimproduct b using (productkey)
inner join dimdate c on a.duedatekey = c.datekey
where (c.calendaryear =2007)
group by b.englishproductname,c.calendaryear
order by sum(salesamount)desc;



--8
select b.calendaryear,b.monthnumberofyear, sum(salesamount)
from factinternetsales a
inner join dimdate b on a.duedatekey = b.datekey
group by b.calendaryear, cube(b.monthnumberofyear)
order by b.calendaryear,b.monthnumberofyear;



--9
select b.englishproductname,count(c.productkey),sum(unitsin),sum(unitsout)
from dimproductsubcategory a
inner join dimproduct b using (productsubcategorykey)
inner join factproductinventory c on c.productkey = b.productkey
inner join dimdate d on c.datekey = d.datekey
where a.englishproductsubcategoryname like 'Tires and Tubes' or a.englishproductsubcategoryname like 'Pedals'
and d.calendaryear = 2006 and d.calendarsemester = 2
group by b.englishproductname



--10
select count(a.calls) "llamadas",count(a.automaticresponses) "respuestas automaticas",count(issuesraised) "problemas resueltos"
from factcallcenter a
inner join dimdate b on a.datekey = b.datekey 
where b.fiscalyear = 2007
and englishdaynameofweek <> 'Saturday' or englishdaynameofweek <> 'Sunday'
and shift like '%AM%'
and weeknumberofyear > 20
