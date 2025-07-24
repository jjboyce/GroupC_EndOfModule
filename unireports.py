## route to combined search and results page ##
from unidata import *
from flask import Flask, render_template_string, request, redirect, render_template
import mysql.connector
app = Flask(__name__)


@app.route('/view_report')
def viewreport():
    selection = request.args.get('selection')
    id = request.args.get('id')
    surname = request.args.get('surname')

    selection_map = {
        'Students without Courses': 'report_1',
        'Students by Lecturer': 'report_2',
        'Courses by Department': 'report_3',
        'Students by Lecturer': 'report_4',
        'Student Overview': 'report_5'
    }

    if not selection:
        return render_template('view_report.html', selection=None, results=None, col_names=None, request=request)

    if selection not in selection_map:
        return "Invalid entity", 400

## start assembling the SQL query

    table = selection_map[selection]
    query = []
    params = []
    print(selection)

### logic to choose correct SQL dependent on entity being queried ## 

    if selection == 'report_1':
            query = "SELECT * FROM TABLE WHERE COURSES IS NIL"
            
    elif selection == 'report_2':
        if id:
            query += " AND student_id = %s"
            params.append(id)
        if surname:
            query += " AND Last_Name LIKE %s"
            params.append(f"%{surname}%")

    elif selection == 'report_3':
        if id:
            query += " AND id = %s"
            params.append(id)
        if surname:
            query += " AND Last_Name LIKE %s"
            params.append(f"%{surname}%")

    elif selection == 'report_4':
        if id:
            query += " AND id = %s"
            params.append(id)
        if surname:
            query += " AND Last_Name LIKE %s"
            params.append(f"%{surname}%")

    elif selection == 'report_5':
        if id:
            query += " AND id = %s"
            params.append(id)
        if surname:
            query += " AND Last_Name LIKE %s"
            params.append(f"%{surname}%")

    ## carries out the SQL Query ##

    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute(query, params)
    results = cursor.fetchall()
    col_names = [desc[0] for desc in cursor.description]
    cursor.close()
    conn.close()

## returns the search template with complete search results ## 
    return render_template(SEARCH_TEMPLATE,
                           results=results,
                           col_names=col_names,
                           request=request)