/* 1. Quantitat de registres de la taula de vols: */
SELECT count(*) FROM `flights`

/* 2. Retard promig de sortida i arribada segons l’aeroport origen. */ 
SELECT `Origin` AS "Origen", 
AVG(`ArrDelay`) AS "prom_arribades", 
AVG(`DepDelay`) AS "prom_sortides" 
FROM `flights` 
GROUP BY Origin

/* 3. Retard promig d’arribada dels vols, per mesos, anys i segons l’aeroport origen. 
A més, volen que els resultat es mostrin de la següent forma (fixa’t en l’ordre de les files): */
SELECT `Origin`,`colYear`,`colMonth`, 
AVG(`ArrDelay`) AS "prom_arribades" 
FROM `flights` 
GROUP BY Origin, colYear, colMonth

/* 4. Retard promig d’arribada dels vols, per mesos, anys i segons l’aeroport origen 
(mateixa consulta que abans i amb el mateix ordre). Però a més, ara volen que en comptes 
del codi de l’aeroport es mostri el nom de la ciutat. */
SELECT `city`,`colYear`,`colMonth`, 
AVG(`ArrDelay`) AS "prom_arribades" 
FROM `flights`, `usairports` 
WHERE Origin = iata 
GROUP BY city, colYear, colMonth
/* corregida query */
SELECT a.city,`colYear`,`colMonth`, 
AVG(`ArrDelay`) AS "prom_arribades" 
FROM `flights` f
LEFT JOIN `usairports` a
ON f.Origin = a.IATA
GROUP BY city, colYear, colMonth
ORDER BY city, colYear, colMonth
/* FIN corrección */


/* 5. Les companyies amb més vols cancelats, per mesos i any. A més, han d’estar ordenades 
de forma que les companyies amb més cancel·lacions apareguin les primeres. */
SELECT `UniqueCarrier`, `colYear`, `colMonth`, 
AVG(`ArrDelay`) AS "avg_delay", 
SUM(`Cancelled`) AS "total_cancelled" 
FROM `flights` 
GROUP BY `colYear`, `colMonth`, `UniqueCarrier` 
ORDER BY `total_cancelled` DESC
/* NOTE: es la versión más parecida a la mostrada al ejemplo */
/* corregida query */
SELECT `UniqueCarrier`, `colYear`, `colMonth`, 
AVG(`ArrDelay`) AS "avg_delay", 
SUM(`Cancelled`) AS "total_cancelled" 
FROM `flights` 
GROUP BY `colYear`, `colMonth`, `UniqueCarrier` 
HAVING SUM(`Cancelled`) > 0
ORDER BY `total_cancelled` DESC
/* FIN corrección */

/* 6. L’identificador dels 10 avions que més distància han recorregut fent vols. */ 
SELECT `TailNum`, SUM(`Distance`) AS "total_distance" 
FROM `flights` 
WHERE `TailNum` <> "" 
GROUP BY `TailNum` 
ORDER BY `total_distance` DESC
/* corregida query */
SELECT `TailNum`, SUM(`Distance`) AS "total_distance" 
FROM `flights` 
WHERE `TailNum` <> "" 
GROUP BY `TailNum` 
ORDER BY `total_distance` DESC
LIMIT 10
/* FIN corrección */

/* 7. Companyies amb el seu retard promig només d’aquelles les quals els seus vols 
arriben al seu destí amb un retràs promig major de 10 minuts. */ 
SELECT `UniqueCarrier`,
AVG(`ArrDelay`) AS "avg_delay"
FROM `flights`
WHERE "avg_delay" < 10
GROUP BY `UniqueCarrier`  
ORDER BY `avg_delay`  DESC
/* corregida query */
SELECT `UniqueCarrier`,
AVG(`ArrDelay`) AS "avg_delay"
FROM `flights`
GROUP BY `UniqueCarrier`  
HAVING AVG(`ArrDelay`) > 10
ORDER BY `avg_delay`  DESC
/* FIN corrección */
