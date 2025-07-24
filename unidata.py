from flask import Flask, render_template_string, request, redirect, render_template
import mysql.connector

app = Flask(__name__)

# Database config
DB_CONFIG = {
    'user': 'test_account',
    'password': 'bluemacbook',
    'host': 'localhost',
    'database': 'endofmod'
}

# Template definitions

HOME_TEMPLATE = 'home_page.html'
SEARCH_TEMPLATE = 'search.html'
REPORTS_TEMPLATE = 'reports.html'
VIEWREPORT_TEMPLATE = 'view_report.html'
SEARCH_RESULTS_TEMPLATE = 'search_results.html'


# DB helper
def get_connection():
    return mysql.connector.connect(**DB_CONFIG)

## route to homepage
@app.route('/')
def home():
    return render_template(HOME_TEMPLATE, context=any)

## route to combined search and results page ##

@app.route('/search')
def search():
    entity = request.args.get('entity')
    id = request.args.get('id')
    surname = request.args.get('surname')

    entity_table_map = {
        'Teachers': 'teachers',
        'Students': 'students',
        'Staff': 'staff',
        'Courses': 'courses'
    }

    if not entity:
        return render_template('search.html', entity=None, results=None, col_names=None, request=request)

    if entity not in entity_table_map:
        return "Invalid entity", 400

    table = entity_table_map[entity]
    query = f"SELECT * FROM {table} WHERE 1=1"
    params = []
    print(entity)

### logic to append correct SQL dependent on entity being queried ## 

    if entity == 'Teachers':
        if id:
            query += " AND teacherID = %s"
            params.append(id)
        if surname:
            query += " AND Last_Name LIKE %s"
            params.append(f"%{surname}%")
            
    elif entity == 'Students':
        if id:
            query += " AND student_id = %s"
            params.append(id)
        if surname:
            query += " AND Last_Name LIKE %s"
            params.append(f"%{surname}%")

    elif entity == 'Staff':
        if id:
            query += " AND id = %s"
            params.append(id)
        if surname:
            query += " AND Last_Name LIKE %s"
            params.append(f"%{surname}%")

    ## connects to the database and carries out the SQL Query ##

    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute(query, params)
    results = cursor.fetchall()
    col_names = [desc[0] for desc in cursor.description]
    cursor.close()
    conn.close()

## returns the search template with complete search results ## 
    return render_template(SEARCH_TEMPLATE,
                           entity=entity,
                           results=results,
                           col_names=col_names,
                           request=request)

## route to the pre-compiled reports initial page ##
@app.route('/reports')
def reports():
    return render_template(REPORTS_TEMPLATE, context=any)

### route to the VIEW REPORT page, which displays the report chosen on the Reports page

@app.route('/view_report')
def viewreport():
    selection = request.args.get('selection')
    id = request.args.get('id')
    surname = request.args.get('surname')

    if not selection:
        return render_template('view_report.html', selection=None, results=None, col_names=None, request=request)

## start assembling the SQL query

    query = []
    params = []
    print(selection)

### logic to choose correct SQL dependent on entity being queried ## 

    if selection == 'Students without Courses':
            query = "SELECT * FROM Departments"
            
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
    return render_template(VIEWREPORT_TEMPLATE,
                           selection=selection,
                           results=results,
                           col_names=col_names,
                           request=request)

if __name__ == '__main__':
    app.run(debug=True)