from pathlib import Path
from csminor import check_cs_minor
from africanaminor import check_as_minor
from anthrominor import check_anthro_minor
from physicsminor import check_physics_minor
from cisminor import check_cis_minor
from psychminor import check_psych_minor
from get_courses import generate_courses_file

option = input("Update courses listings? (Y/N): ")
if option == 'Y':
    generate_courses_file()

course_file_name = input("Enter course file name: ")
course_file_path = Path(course_file_name)
course_file = open(course_file_path)
user_courses = course_file.readlines()
user_courses = [course.strip() for course in user_courses]

cs_minor_courses_left = check_cs_minor(user_courses)
as_minor_courses_left = check_as_minor(user_courses)
anthro_minor_courses_left = check_anthro_minor(user_courses)
physics_minor_courses_left = check_physics_minor(user_courses)
cis_minor_courses_left = check_cis_minor(user_courses)
psych_minor_courses_left = check_psych_minor(user_courses)

print(cs_minor_courses_left)
print(as_minor_courses_left)
print(anthro_minor_courses_left)
print(physics_minor_courses_left)
print(cis_minor_courses_left)
print(psych_minor_courses_left)
