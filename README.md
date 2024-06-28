# Shakespeare Play Text Analysis Project

## Overview

This project involves analyzing the text of Shakespeare's plays using SQL Server. The primary objectives include creating and populating tables with character names and play text, updating specific portions of the text, and deleting certain lines. Additionally, the project measures the performance of various queries, recording the execution times in a dedicated performance table.

## Objectives

1. **Data Insertion**: Insert character names and play text into their respective tables.
2. **Text Update**: Capitalize the character names within the play text.
3. **Line Deletion**: Remove lines that contain stage directions such as "Enter", "Exit", "Act", etc.
4. **Performance Measurement**: Record the execution time of each operation (insert, update, delete, read) to analyze query performance.

## Project Components

### Tables

- **characters**: Stores the names of characters from the play.
- **amnd**: Stores lines of text from "A Midsummer Night's Dream".
- **performance**: Logs the action performed (insert, update, delete, read) along with the execution time.

### Procedures

1. **Insert Procedure**: Handles the insertion of play text lines into the `amnd` table.
2. **Update Procedure**: Capitalizes character names within the play text.
3. **Delete Procedure**: Removes lines with stage directions from the play text.
4. **Read Procedure**: Retrieves lines from the play text and measures the query execution time.

### Performance Logging

The project focuses on logging the execution time of each query to the `performance` table. This allows for detailed analysis and optimization of query performance. Execution times are recorded in seconds with high precision to ensure accurate performance metrics.

## Usage

1. **Setting Up the Database**: Create the necessary tables and
