### Introduction

There are many ways to skin a cat in Azure, and that is quite applicable to the case when you need to build a Data Warehouse. For the purpose of this presentation we will cover two design choices: one that uses Azure Synapse / Power BI, the other one that uses Azure Sql Server / Power BI.

##### Deploy an on-prem Sql Server database

For the purpose of demonstrating the two different implementations of an Azure Data Warehouse, we will need to setup a sample data source, in the shape of a database deployed on-prem (your own local machine.) This database is a sample of Student Courses information and has the following schema.

![Student-Courses-DB-Schema](https://user-images.githubusercontent.com/6631390/117579152-a6495d00-b0bf-11eb-9a2e-4a66bb1fd3be.PNG)

The following 2 Sql scripts are used to create a new instance of StudentCourses database and populate it with sample data.

[Create_StudentCoursesDatabase.sql](https://https://github.com/antongeorgescu/azure-data-warehouse/blob/master/SampleDatabase/Create_StudentCoursesDatabase.sql)

[Populate_StudentCoursesDatabase.sql](https://github.com/antongeorgescu/azure-data-warehouse/blob/master/SampleDatabase/Populate_StudentCoursesDatabase.sql)

*Note*: The following two views are providing the data sources for two parquet files that will be uploaded in Azure Blob Storage (schemas are provided under each):

[Create_vwInstructorCourseDepartment.sql](https://github.com/antongeorgescu/azure-data-warehouse/blob/master/SampleDatabase/create_vwInstructorCourseDepartment.sql)

![vwInstructorCourseDepartment](https://user-images.githubusercontent.com/6631390/117579387-a007b080-b0c0-11eb-93de-bfd244907191.PNG)

[Create_vwStudentCourseGrade.sql](https://github.com/antongeorgescu/azure-data-warehouse/blob/master/SampleDatabase/create_vwStudentCourseGrade.sql)

![vwStudentCourseGrade](https://user-images.githubusercontent.com/6631390/117579425-c3326000-b0c0-11eb-8721-a1e730ad792f.PNG)

##### Generate parquet files from data source

The Python script under [studentdb_to_parquet.py](https://github.com/antongeorgescu/azure-data-warehouse/blob/master/PythonScripts/studentdb_to_parquet.py) extracts the data from sample database and creates a parquet file (as alternatives, csv and json files can be created as well.)

![python_dataframe_to_parquet](https://user-images.githubusercontent.com/6631390/117580178-b0218f00-b0c4-11eb-9696-d545e3035802.PNG)


### Data Warehouse with Azure Sql Server

---

#### Solution Overview

In a Data Lake model on Azure Cloud, data generally lands on the Azure storage layer using the Azure Blob Storage, especially for semi-structured data. Data may be exported from various data sources in the form of JSON, CSV, Parquet, ORC and various formats and hosted on blob storage, from where it would be channeled to other purpose-specific repositories. Azure SQL Database is one of the most popular data repositories for hosting structured data on the Azure cloud. From this perspective, Azure blob storage is one of the most frequently used data sources and Azure SQL Database is of the most frequently used data destinations. Azure Data Factory on Azure cloud helps to transport and transform data from-and-to to a variety of data repositories. In this article, we will learn how to use Azure Data Factory to populate data from Azure Blob Storage to Azure SQL Database.

#### Azure Block Blobs Storage

It is a scalable object storage for documents, videos, pictures and unstructured text or binary data. Choose from Hot, Cool or Archive tiers.

#### Initial Setup

In this approach, we will source data from Azure Blob storage and populate the same into Azure SQL Database. For this, we need a few items to be set up, before we can start focusing on the actual exercise of populating the destination with the source using Azure Data Factory.

##### Steps Required

* Setup an Azure Storage Account

Account name is "alviandastorage" and has the features populated in the snapshot below.

![azurestorage-with-azureblob](https://user-images.githubusercontent.com/6631390/117578631-42259980-b0bd-11eb-9dd5-4b98ea9e5f2a.PNG)

* Create an Azure Blob container associated with the storage account

![azure-blob-containers](https://user-images.githubusercontent.com/6631390/117578759-e8719f00-b0bd-11eb-9fed-48d72f8cb43c.PNG)

* Create an Azure SQL Database hosted on an Azure SQL Server instance.

This would act as the destination where we would populate the data from the source files using the Azure Data Factory.

![azure-sqlserver-database](https://user-images.githubusercontent.com/6631390/117578897-9bda9380-b0be-11eb-8b0f-d56cf3aaa4fa.PNG)

Once the above pre-requisites are setup, we can proceed with the rest of the exercise which would focus on populating the data from source to destination.

##### Use Azure Data Factory for Data Intake

To start populating data with Azure Data Factory, firstly we need to create an instance. From the navigation pane, select **Data factories** and open it. You would find a screen as shown below. If you do not have any existing instance of Azure Data Factory, you would find the list blank. Click on the **Create data factory button** to start creating an instance.

There are 3 steps required to create a "copy data" data factory, shown in the three snapshots below

Select "Copy data" type of data factory

![copy-data-factory](https://user-images.githubusercontent.com/6631390/117582463-1fe94700-b0d0-11eb-8911-5b671796ff91.PNG)

Select "Author & Monitoring" to get into data factory design screens

![author-and-monitor-data-factory](https://user-images.githubusercontent.com/6631390/117582426-efa1a880-b0cf-11eb-8372-609f08aeabbe.png)

Go through the steps required to set up the data copy, including the AlviandaBlobStorage (where the parquet files are stored) and AlviandaDatabase where (Azure Sql Server database resides)

You would find different options on the portal. Click on the Copy Data option and it would open up a new wizard as shown below. Let’s proceed step by step to provide the relevant source, destination and mapping details. In the first step, provide the task name and select the frequency of execution. For now, we can continue with defaults on this step and click on the **Next ** button.

![azure-data-factory-copy-data-tool](https://user-images.githubusercontent.com/6631390/117582609-cd5c5a80-b0d0-11eb-9af5-5dea7861004f.png)

![datafactory-copy-parquet-to-sql](https://user-images.githubusercontent.com/6631390/117582312-69856200-b0cf-11eb-937a-bf9acb5f31a1.PNG)

Azure Data Factory supports many data sources. For our exercise, we need to select Azure Blob Storage as the linked service in the data source setup. Click on the continue button. Pick up **Azure Blob Storage** from the list.

![azure-blob-storage-connectors](https://user-images.githubusercontent.com/6631390/117582668-24fac600-b0d1-11eb-84e5-ac82f8a6d529.png)

At this point you can display the content of the file that's stored in the blob and contains the source data.

![datafactory-parquet-source](https://user-images.githubusercontent.com/6631390/117584387-9ee37d00-b0da-11eb-8ccc-bedf0f419bc6.PNG)

Then choose the data destination (target) store. Select **Azure Sql Server** from the list:

![azure-database-destination](https://user-images.githubusercontent.com/6631390/117582752-89b62080-b0d1-11eb-8a30-84e368187728.png)

In this step, after the table mapping, we need to provide details of column mapping. You can choose to continue with the default mappings or change it. In this case, here we have changed the data type of one of the fields – Customer ID, from String to Int32 for testing purposes. After configuring the column mapping properties, click on the Next button.

![datafactory-column-mapping](https://user-images.githubusercontent.com/6631390/117584172-6abb8c80-b0d9-11eb-8ebe-002041e89470.PNG)

For demo purposes, we choose to "auto-create the table in Sql Server database." In real life, Sql Server will have a pre-defined schema and the data mapping will ensure that the values read from the blob storage files (eg parquet) will be stored in the proper tables, validated by tables validation rules.

In this step, we can configure settings for data parallelism, data consistency and other relevant details. We can continue with defaults as these steps are optional. Click on the Next button.

![performance-and-verification-settings](https://user-images.githubusercontent.com/6631390/117584258-ea495b80-b0d9-11eb-9e5c-8eef84cb5fdb.png)

Finally, we are on the Summary page where the entire configuration details are available for review and editing. After confirming the same, click on the Next button.

![datafactory-task-run](https://user-images.githubusercontent.com/6631390/117584284-18c73680-b0da-11eb-995e-7015bd633fdd.PNG)

Th schema of StudentDW database can be seen by using Query Editor

![loanstar-sqldb-schema](https://user-images.githubusercontent.com/6631390/117585262-7316c600-b0df-11eb-839b-9d5a12bdda5f.PNG)



To verify the newly populated data in the Azure SQL Database, connect to the database using Azure Query Editor, SSMS, or Visual Studio as shown below, and you would find the data successfully loaded in a new table as shown below.

![view-azure-sqlserver-data-with-visual-studio](https://user-images.githubusercontent.com/6631390/117584587-c555e800-b0db-11eb-9582-f31d157ee2d9.PNG)

#### Reporting with Power BI

In order to run Power BI analytics with data stored in Azure Sql Server, we need to first have Power BI Desktop application deployed on local machine. Power BI Desktop is free and can be downloaded from [https://powerbi.microsoft.com/en-us/downloads/](https://powerbi.microsoft.com/en-us/downloads/)

As per Microsoft, with the Power BI Desktop you can visually explore your data through a free-form drag-and-drop canvas, a broad range of modern data visualizations, and an easy-to-use report authoring experience.

There are a few steps required to create and publish Data Warehouse reports (both canned and analytics) by using Power BI Desktop and Power BI wbe (located on Azure)

Open Power BI Desktop and select the data source that sits in Azure Sql Server, under **loanstarpoc** server. The following snapshots show the sequence of selections.

* Connect to Azure Sql Server database called StudentDW

![PowerBI-Connect](https://user-images.githubusercontent.com/6631390/117584913-a22c3800-b0dd-11eb-8fc3-1e834bcbc5be.PNG)

![PowerBI-Connect-Azure-db](https://user-images.githubusercontent.com/6631390/117584940-c0923380-b0dd-11eb-8af0-471e8289f4b1.PNG)

![PowerBI-Connect-Azure-db-2](https://user-images.githubusercontent.com/6631390/117584967-ea4b5a80-b0dd-11eb-9231-9486234b4188.PNG)

* Load the data from Azure Sql Server database

![PowerBI-Load-Data](https://user-images.githubusercontent.com/6631390/117584973-fcc59400-b0dd-11eb-944b-53c2fe07fe44.PNG)

* create and visualize a report

![PowerBI-Report](https://user-images.githubusercontent.com/6631390/117585002-241c6100-b0de-11eb-9d94-1330c9afb195.PNG)


* publish the report by using "Publish" button located on Power BI Desktop Dashboard

Once published the report will show up in the corresponding workspace of Azure Power BI


#### Reporting with ASP.NET Core MVC

Another way is to use ASP.NET Core MVC application and ChartJs library to show the same data that Power BI displays. The .NET implementation requires coding and C# skills. Below isthe snapshot of an example built and stored in this repository under [https://github.com/antongeorgescu/azure-data-warehouse/tree/master/DWChart-ASPNETCore](https://github.com/antongeorgescu/azure-data-warehouse/tree/master/DWChart-ASPNETCore)

![ASP_NET_Core_MVC_Reports](https://user-images.githubusercontent.com/6631390/117585146-cd635700-b0de-11eb-9596-b361d63d0fa9.PNG)

#### Conclusion

In this section, we performed an exercise with the setup of Azure blob storage and Azure SQL Database as the source and destination. We used Azure Data Factory as the integrator to source data from a CSV file hosted in a container on Azure blob storage, configured and created the data pipeline, and populated this data in Azure SQL Database as the destination for this pipeline. We also learned different artifacts of Azure Data Factory like Linked Services, Pipelines, Azure Data Factory instance and configuration settings.

### Data Warehouse with Azure Synapse

---

This section presenst a different architecture, that relies on Azure Synapse. Although different in nature, both solutions are using common elements, therefore for the rest of the section we will make references to previous design wherever the same techniques and components are used.

#### What is Azure Synapse

Azure Synapse is an enterprise analytics service that accelerates time to insight across data warehouses and big data systems. Azure Synapse brings together the best of SQL technologies used in enterprise data warehousing, Spark technologies used for big data, Pipelines for data integration and ETL/ELT, and deep integration with other Azure services such as Power BI, CosmosDB, and AzureML.

#### Azure Synapse Architecture

![synapse-architecture](https://user-images.githubusercontent.com/6631390/117586801-7793ac80-b0e8-11eb-9f2d-5fdee01210b5.png)

#### Why Azure Synapse?

Azure Synapse is in the same time a versatile and an integrated environment that puts under the same umbrella technologies, techniques and components that otherwise live in separation. Down below is a list of its most important features

##### Synapse uses SQL

**Synapse SQL** is a distributed query system for T-SQL that enables data warehousing and data virtualization scenarios and extends T-SQL to address streaming and machine learning scenarios.

* Synapse SQL offers both **serverless** and **dedicated** resource models. For predictable performance and cost, create dedicated SQL pools to reserve processing power for data stored in SQL tables. For unplanned or bursty workloads, use the always-available, serverless SQL endpoint.
* Use built-in **streaming** capabilities to land data from cloud data sources into SQL tables
* Integrate AI with SQL by using **machine learning** models to score data using the [T-SQL PREDICT function](https://docs.microsoft.com/en-us/sql/t-sql/queries/predict-transact-sql?view=azure-sqldw-latest&preserve-view=true)

##### Synapse uses Apache Spark

Apache Spark is a lightning-fast cluster computing designed for fast computation. It was built on top of Hadoop MapReduce and it extends the MapReduce model to efficiently use more types of computations which includes Interactive Queries and Stream Processing.

Apache Spark is the most popular open source big data engine used for data preparation, data engineering, ETL, and machine learning.

* ML models with SparkML algorithms and AzureML integration for Apache Spark 2.4 with built-in support for Linux Foundation Delta Lake.
* Simplified resource model that frees you from having to worry about managing clusters.
* Fast Spark start-up and aggressive autoscaling.
* Built-in support for .NET for Spark allowing you to reuse your C# expertise and existing .NET code within a Spark application.

##### Synapse uses PolyBase

PolyBase is a tool built in with SQL Server (2016 and up) and Azure SQL Data Warehouse that allows you to query data from outside files stored in Azure Blob Storage or Azure Data Lake Store. Once we define a file type within SQL Server Management Studio (SSMS), we can simply insert data from the file into a structured external table. Now since the structured table is ready, we can compare and update tables using the external table and the destination table.

The advantages of using PolyBase directly comes with the ability to use familiar SQL queries to much of transforming and copying activities within the data warehouse.

##### Synapse uses Azure Data Lake Storage

Data Lake combines the power of a Hadoop compatible file system with integrated hierarchical namespace with the massive scale and economy of Azure Blob Storage to help speed your transition from proof of concept to production.

Azure Synapse removes the traditional technology barriers between using SQL and Spark together. You can seamlessly mix and match based on your needs and expertise.

* Tables defined on files in the data lake are seamlessly consumed by either Spark or Hive.
* SQL and Spark can directly explore and analyze Parquet, CSV, TSV, and JSON files stored in the data lake.
* Fast, scalable data loading between SQL and Spark databases

##### Synapse uses built-in data integration

Azure Synapse contains the same Data Integration engine and experiences as Azure Data Factory, allowing you to create rich at-scale ETL pipelines without leaving Azure Synapse Analytics.

* Ingest data from 90+ data sources
* Code-Free ETL with Data flow activities
* Orchestrate notebooks, Spark jobs, stored procedures, SQL scripts, and more

#### Main capabilities of Synapse

##### The Built-in serverless SQL pool

Serverless SQL pools let you use SQL without having to reserve capacity. Billing for a serverless SQL pool is based on the amount of data processed to run the query and not the number of nodes used to run the query.

Every workspace comes with a pre-configured serverless SQL pool called **Built-in** .

Below you can find a few examples of data explration applied to the parquet file extracted from StudentCourse sample database. See this extraction explained in detail under "**Deploy an on-prem Sql Server database**" above

![DbExplore_Query_AllCourses](https://user-images.githubusercontent.com/6631390/117587237-e3771480-b0ea-11eb-82ac-666e741021e3.PNG)

The query above executes a union between 2 parquet files (StudentCourses.parquet & InstructorCourses.parquet)

This is done by using a wildcard applied to the files having "Courses" in their names


![DbExplore_Query_InstructorCourses](https://user-images.githubusercontent.com/6631390/117587286-233dfc00-b0eb-11eb-8a77-175836d9696c.PNG)

The query above only queries instructorCourses.parquet file

### References

---

[Populate Azure SQL Database from Azure Blob Storage using Azure Data Factory](https://www.sqlshack.com/populate-azure-sql-database-from-azure-blob-storage-using-azure-data-factory/)

[Configure PolyBase to access external data in Azure Blob Storage](https://docs.microsoft.com/en-us/sql/relational-databases/polybase/polybase-configure-azure-blob-storage?view=sql-server-ver15)

[Query Parquet files using serverless SQL pool in Azure Synapse Analytics](https://docs.microsoft.com/en-us/azure/synapse-analytics/sql/query-parquet-files)
