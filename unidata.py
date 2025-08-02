from flask import Flask, render_template_string, request, redirect, render_template
import mysql.connector

app = Flask(__name__)

# Database config (pointing to local)
DB_CONFIG = {
    'user': 'test_account',
    'password': 'bluemacbook',
    'host': 'localhost',
    'database': 'endofmodtwo'
}

## Template definitions

HOME_TEMPLATE = 'home_page.html'
SEARCH_TEMPLATE = 'search.html'
REPORTS_TEMPLATE = 'reports.html'
VIEWREPORT_TEMPLATE = 'view_report.html'
VIEWSTUDENT_TEMPLATE = 'view_student.html'
STUDENT_SEARCH_TEMPLATE = 'student_search.html'


## DB helper
def get_connection():
    return mysql.connector.connect(**DB_CONFIG)

    """
    FLASK ROUTES TO HOME AND SEARCH PAGES WITHIN THE APP
    """
## route to homepage
@app.route('/')
def home():
    return render_template(HOME_TEMPLATE, context=any)

## route to combined STAFF search and results page ##

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

    """
    SEARCH LOGIC TO APPEND CORRECT SQL DEPENDING ON TABLE BEING QUERIED    
    """

### logic to append correct SQL dependent on entity being queried ## 

    if entity == 'Lecturers':
        if id:
            query += " AND Lecturer_id = %s"
            params.append(id)
        if surname:
            query += " AND name LIKE %s"
            params.append(f"%{surname}%")
            
    elif entity == 'Students':
        if id:
            query += " AND student_id = %s"
            params.append(id)
        if surname:
            query += " AND name LIKE %s"
            params.append(f"%{surname}%")

    elif entity == 'Non Academic Staff':
        if id:
            query += " AND staff_id = %s"
            params.append(id)
        if surname:
            query += " AND name LIKE %s"
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

    """
    Section deals with nagigation to the Reports and View Reports pages, and logic to assemble SQL Request for View Reports
    """

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

### logic to choose correct SQL dependent on entity being queried ## 

    if selection == 'High Performing Students':
        query = """
        select rc.student_id, s.name, AVG(grade), AVG(grade) > 70 from registered_courses rc
        inner join students s on s.student_id = rc.student_id
        group by rc.student_id
        having AVG(rc.grade) > 70;
        """
        
    elif selection == 'Courses by Department':
        query = """
        select rc.course_code, c.name, c.department, l.name as Lecturer
        from registered_courses rc 
        inner join courses c on rc.course_code = c.course_code
        inner join lecturers l on l.lecturer_id = rc.lecturer_id
        where c.department = %s
        group by rc.lecturer_id, rc.course_code, c.name
        """
        params = argument


    elif selection == 'Students by Lecturer':
        query = """
        select s.name as studentname, c.name, l.name as Lecturer from registered_courses rc
        inner join courses c on rc.course_code = c.course_code
        inner join lecturers l on l.lecturer_id = rc.lecturer_id
        inner join students s on s.student_id = rc.student_id
        where 1=1
        """
        if not argument == ['']:
            query += " AND (l.name = %s OR l.lecturer_id = %s)"
            params = (argument[0], argument[0])
            

    elif selection == 'Student Advisors':
        query = """
        select s.name, l.name as Advisor from students s
        inner join lecturers l on s.advisor = l.lecturer_id
        where 1=1
        """
        if not argument == ['']:
            query += " AND (s.name = %s OR s.student_id = %s)"
            params = (argument[0], argument[0])
            

    elif selection == 'Lecturer Expertise':
        query = """
        select l.name, l.areas_of_expertise from lecturers l 
        where 1+1
        """
        if not argument == ['']:
            query += " AND areas_of_expertise = %s"
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

## route to combined STUDENT search and results page ##

@app.route('/student_search')
def student_search():
    student_id = request.args.get('student_ID')
    surname = request.args.get('surname')

    query = """
    select student_ID, name from students
    where 1+1
    """
    params = []

    """
    SEARCH LOGIC TO APPEND CORRECT SQL DEPENDING ON TABLE BEING QUERIED    
    """

### logic to append correct SQL dependent on field being queried ## 

    if student_id:
        query += " AND student_ID = %s"
        params.append(student_id)

    if surname:
        query += " AND name like %s"
        params.append(surname)

    #if student_id is [''] and surname is ['']:
        #return render_template(STUDENT_SEARCH_TEMPLATE,
                               #surname=surname,
                               #student_id=student_id,
                               #col_names=col_names,
                               #request=request,
                               #results=results)
    
            
    ## connects to the database and carries out the SQL Query ##

    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute(query, params)
    results = cursor.fetchall()
    col_names = [desc[0] for desc in cursor.description]
    cursor.close()
    conn.close()


## returns the search template with complete search results ## 
    return render_template(STUDENT_SEARCH_TEMPLATE,
                           surname=surname,
                           student_id=student_id,
                           results=results,
                           col_names=col_names,
                           request=request)

"""
SECTION FOR VIEW STUDENT PAGE
"""
@app.route('/view_student')
def viewstudent():
    student_id = request.args.get('student_id')

## start assembling the SQL query

    query = []
    params = []

### logic to map create SQL Query for additional Student Data ##

    query = """
            select s.student_id, s.name, s.program_enroll_in, l.name as Lecturer from students s
            inner join Lecturers l on s.advisor = l.Lecturer_id
            where 1=1
            """
    
    query += " AND s.student_id = %s"
    params.append(student_id)
    
    print(f"THE QUERY IS: {query} ")
    ## carries out the SQL Query ##
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute(query, params)
    results = cursor.fetchall()
    col_names = [desc[0] for desc in cursor.description]
    cursor.close()
    conn.close()

## returns the view student template with complete details ## 
    return render_template(VIEWSTUDENT_TEMPLATE,
                           student_id=student_id,
                           results=results,
                           col_names=col_names,
                           request=request)


if __name__ == '__main__':
    app.run(debug=True)