from flask import Flask, render_template_string, request, redirect, render_template
import mysql.connector

app = Flask(__name__)

# Database config (pointing to local)
DB_CONFIG = {
    'user': 'test_account',
    'password': 'bluemacbook',
    'host': 'localhost',
    'database': 'endofmod'
}

## Template definitions

HOME_TEMPLATE = 'home_page.html'
SEARCH_TEMPLATE = 'search.html'
REPORTS_TEMPLATE = 'reports.html'
VIEWREPORT_TEMPLATE = 'view_report.html'
SEARCH_RESULTS_TEMPLATE = 'search_results.html'


## DB helper
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
        'Lecturers': 'Lecturers',
        'Students': 'Students',
        'Non Academic Staff': 'Non_Academic_Staff',
        'Courses': 'Courses'
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

    if entity == 'Lecturers':
        if id:
            query += " AND Lecturer_id = %s"
            params.append(id)
        if surname:
            query += " AND last_Name LIKE %s"
            params.append(f"%{surname}%")
            
    elif entity == 'Students':
        if id:
            query += " AND student_id = %s"
            params.append(id)
        if surname:
            query += " AND last_Name LIKE %s"
            params.append(f"%{surname}%")

    elif entity == 'Non Academic Staff':
        if id:
            query += " AND staff_id = %s"
            params.append(id)
        if surname:
            query += " AND last_Name LIKE %s"
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

### REPORTS SECTION: route to the VIEW REPORT page, which displays the report chosen on the Reports page

@app.route('/view_report')
def viewreport():
    selection = request.args.get('selection')
    ##id = request.args.get('id')
    ##surname = request.args.get('surname')

    if not selection:
        return render_template('view_report.html', selection=None, results=None, col_names=None, request=request)

## start assembling the SQL query

    query = []
    params = []
    argument = [request.args.get('argument')]


### this block defines the parameters being passed from the form


### logic to choose correct SQL dependent on entity being queried ## 

    if selection == 'High Performing Students':
        query = """
        
        select rc.student_id, s.first_name, s.last_name, AVG(grade) > 70 from registered_courses rc 
        inner join students s on s.student_id = rc.student_id
        group by rc.student_id
        having AVG(rc.grade) > 70;
        """
        
    elif selection == 'Courses by Department':
        query = """
        select rc.lecturer_id, rc.course_code, c.course_name, c.department_name
        from registered_courses rc 
        inner join courses c on rc.course_code = c.course_code
        where c.department_name = %s
        group by rc.lecturer_id, rc.course_code, c.course_name; 
        """
        params = argument
        print(argument)


    elif selection == 'Students by Lecturer':
        query = """
        select s.first_name as student_first_name, s.last_name as student_last_name, c.course_name, l.first_name as Lecturer_first_name, l.last_name as lecturer_last_name from registered_courses rc
        inner join courses c on rc.course_code = c.course_code
        inner join lecturers l on l.lecturer_id = rc.lecturer_id
        inner join students s on s.student_id = rc.student_id
        where 1=1
        """
        if argument:
            query += " AND l.last_name = %s OR l.lecturer_id = %s"
            params = (argument[0], argument[0])
            

    elif selection == 'Student Advisors':
        query = """
        select l.first_name as advisor_first_name, l.last_name as advisor_last_name from students s
        inner join lecturers l on s.advisor = l.lecturer_id
        where 1=1
        """
        if argument:
            query += " AND s.last_name = %s OR s.student_id = %s"
            params = (argument[0], argument[0])
            

    elif selection == 'Lecturer Expertise':
        query = """
        select l.first_name, l.last_name, l.research_area from lecturers l 
        where 1+1
        """
        if argument:
            query += " AND research_area = %s"
            params = argument

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