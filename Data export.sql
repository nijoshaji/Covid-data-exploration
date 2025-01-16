SELECT * FROM covid.vaccination_progress
into outfile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Covid_vac_progress.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';