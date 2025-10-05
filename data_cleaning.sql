-- Data Cleaning

select *
from layoffs;

-- 1. Remove Duplicates
-- 2. Standardize the Data
-- 3. Null Values or Blank Values
-- 4. Remove Any Columns or Rows

-- create a copy  --
create table layoffs_staging
like layoffs;

insert layoffs_staging
select *
from layoffs;

select *
from layoffs_staging;


-- 1. Remove Duplicates --

with duplicate_cte as (
	select
		*,
		row_number() over(
			partition by  company, industry, total_laid_off, `date`, stage, country, funds_raised_millions
			) as row_num
	from layoffs_staging
)
select *
from duplicate_cte
where row_num > 1;

CREATE TABLE `layoffs_staging2` (
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

insert into layoffs_staging2
select
	*,
	row_number() over(
		partition by  company, industry, total_laid_off, `date`, stage, country, funds_raised_millions
		) as row_num
from layoffs_staging;

select *
from layoffs_staging2
where row_num > 1;

delete
from layoffs_staging2
where row_num > 1;

select *
from layoffs_staging2;


-- 2. Standardize the Data --

select company, trim(company)
from layoffs_staging2;

update layoffs_staging2
set company=trim(company);

select distinct industry
from layoffs_staging2
order by 1;

select *
from layoffs_staging2
where industry like 'Crypto%';

update layoffs_staging2
set industry='Crypto'
where industry like 'Crypto%';

select distinct location
from layoffs_staging2
order by 1;

select distinct country
from layoffs_staging2
order by 1;

update layoffs_staging2
set country=trim(trailing '.' from country)
where country like 'United States%';

select *
from layoffs_staging2;

select 
	`date`,
	str_to_date(`date`, '%m/%d/%Y')
from layoffs_staging2;

update layoffs_staging2
set `date`=str_to_date(`date`, '%m/%d/%Y');

alter table layoffs_staging2
modify column `date` date;

-- 3. Null Values or Blank Values --

select *
from layoffs_staging2
where industry is null or industry = '';

update layoffs_staging2
set industry=null
where industry='';

select t1.industry, t2.industry
from layoffs_staging2 as t1
join layoffs_staging2 as t2 
	on t1.company=t2.company
    and t1.location=t2.location
where t1.industry is null and t2.industry is not null;

update layoffs_staging2 as t1
join layoffs_staging2 as t2 on t1.company=t2.company
set t1.industry=t2.industry
where t1.industry is null
	and t2.industry is not null;

select *
from layoffs_staging2;


select *
from layoffs_staging2
where total_laid_off is null 
	and percentage_laid_off is null;

delete
from layoffs_staging2
where total_laid_off is null 
	and percentage_laid_off is null;
    
    
-- 4. Remove Any Columns or Rows--

alter table layoffs_staging2
drop column row_num;


