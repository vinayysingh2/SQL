
									-- DUPLICATE VALUES --

select * from layoffs;

create table layoff_staging
like layoffs;

select * from layoff_staging;

Insert layoff_staging
select * 
from layoffs;

select * from layoff_staging;

select *, ROW_NUMBER() OVER(
partition by company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num 
from layoff_staging;

with duplicate_cte as
( 
select *, ROW_NUMBER() OVER(
partition by company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num 
from layoff_staging
)
delete from duplicate_cte
where row_num > 1;

CREATE TABLE `layoff_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select * from layoff_staging2;

Insert into layoff_staging2
select *, ROW_NUMBER() OVER(
partition by company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num 
from layoff_staging;

select * from layoff_staging2;

select * from layoff_staging2
where row_num > 1;

SET SQL_SAFE_UPDATES = 0;

delete 
from layoff_staging2
where row_num > 1;

select *
from layoff_staging2
where row_num > 1;

select * from layoff_staging2;

											-- STANDARDIZE DATA --

select distinct(company),trim(company) from layoff_staging2;

select *  from layoff_staging2
where industry like 'Cry%';

update layoff_staging2
set industry = 'Crypto'
where industry like 'Crypto%';

select distinct location from layoff_staging2
order by 1;

select * from layoff_staging2
where location like '%orf';

update layoff_staging2 
set location = 'Dusseldorf'
where location like '%sseldorf';

select distinct country from layoff_staging2
order by 1 asc;

select * from layoff_staging2
where country = 'United States.';

update layoff_staging2 
set country = 'United States'
where country like 'United States%';

select `date` 
from layofdatef_staging2;

update layoff_staging2
set `date` = str_to_date(`date`,'%Y-%m-%d');

alter table layoff_staging2
modify column `date` date;

													-- NULL VALUES --

select * from layoff_staging2
where total_laid_off IS NULL
and percentage_laid_off IS NULL;

update layoff_staging2 
set industry = NULL
where industry = '';

select * from layoff_staging2
where industry IS NULL 
or industry = '' ;

select * from layoff_staging2
where company = 'Airbnb' and location = 'SF Bay Area';

select t1.industry,t2.industry from layoff_staging2 t1
join layoff_staging2 t2
	on t1.company = t2.company
where (t1.industry is null or t1.industry = '')
and t2.industry is not null;

update layoff_staging2 t1
join layoff_staging2 t2
	on t1.company = t2.company
set t1.industry = t2.industry
where t1.industry is null 
and t2.industry is not null;

select t1.industry,t2.industry from layoff_staging2 t1
join layoff_staging2 t2
	on t1.company = t2.company
where t1.industry is  not null 
and t2.industry is not null;

select * from layoff_staging2;

select * from layoff_staging2
where total_laid_off IS NULL
and percentage_laid_off IS NULL;

delete 
from layoff_staging2
where total_laid_off is null
and percentage_laid_off is null;

select * from layoff_staging2;
											-- REMOVE ROWS OR COLUMNS
alter table layoff_staging2
drop column row_num;

select * from layoff_staging2;

delete 
from layoff_staging2
where total_laid_off IS NULL or percentage_laid_off IS NULL;


