from pathlib import Path
from csminor import check_cs_minor

course_file_name = input("Enter course file name: ")
course_file_path = Path(course_file_name)
course_file = open(course_file_path)
user_courses = course_file.readlines()
user_courses = [course.strip() for course in user_courses]

cs_minor_courses_left = check_cs_minor(user_courses)

print(cs_minor_courses_left)