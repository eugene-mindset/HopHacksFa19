from tkinter import *
from tkinter import messagebox
from tkinter.font import Font
from tkinter.scrolledtext import ScrolledText
import re
from majors_minors import degree_calculations

def rgb_to_hex(r, g, b):
    return '#' + ''.join('{:02X}'.format(x) for x in [r, g, b])

colorHeritageBlue = rgb_to_hex(0, 45, 114)
colorSpiritBlue = rgb_to_hex(114, 172, 229)
colorWhite = rgb_to_hex(255, 255, 255)
colorTransparency = rgb_to_hex(255, 255, 0)
fontGeorgia = ("Georgia", 18, "bold")
fontGeorgia2 = ("Georgia", 14, "bold")
fontGeorgia3 = ("Georgia", 10, "bold")

def callback():
    """Method to close application properly."""

    if messagebox.askokcancel("Quit", "Do you really wish to quit?"):
        root.destroy()


class App:
    # Creates application
    def __init__(self, master):
        self.initUI(master)

    def initUI(self, master):

        master.title("Testing UI")
        self.input_frame = Frame(
            master, 
            background=colorHeritageBlue
        )
        self.input_frame.pack(
            side=LEFT,
            fill=BOTH, 
            expand=True,
        )

        self.buffer_frame = Frame(
            master, background=rgb_to_hex(255, 255, 255)
        )
        self.buffer_frame.pack(
            side=RIGHT, 
            fill=BOTH, 
            expand=True, 
            ipadx=200
        )

        self.add_course_label = Label(
            self.input_frame, 
            text="Enter courses below...", 
            background=colorHeritageBlue
        )
        self.add_course_label.pack(
            side=TOP,
            fill=X
        )
        self.add_course_label.configure(
            font=fontGeorgia, 
            fg=colorWhite
        )

        self.semester_entries = self.generate_fields(5, 2017, True)

        self.submit_button = Button(
            self.input_frame,
            text="Enter",
            bg=colorSpiritBlue,
            bd=0,
            font=fontGeorgia,
            command=self.enter_info
        )
        self.submit_button.pack(
            side=TOP,
            padx=50,
            pady=0,
            fill=BOTH,
        )

        self.return_button = Button(
            self.input_frame,
            text="Return",
            bg=colorSpiritBlue,
            bd=0,
            font=fontGeorgia,
            command=self.return_back
        )
        self.return_button.pack(
            side=TOP,
            padx=50,
            pady=0,
            fill=BOTH,
        )

        self.out_label = Label(
            self.buffer_frame,
            font=fontGeorgia3,
            wraplength=400,
            bg=colorWhite,
            justify=LEFT
        )

        self.out_label.pack(
            side=TOP,
            fill=X,
            expand=True
        )

    def generate_fields(self, count: int, startYear: int, startFall: bool):
        semesters = {}
        
        for x in range(0, count):
            text = ""
            year = startYear

            if x % 2 == 0:
                if startFall:
                    text = "Fall " + str(year + (x + 1) // 2)
                else:
                    text = "Spring " + str(year + x // 2)
            elif x % 2 == 1:
                if not startFall:
                    text = "Fall " + str(year + x // 2)
                else:
                    text = "Spring " + str(year + (x + 1) // 2)

            semester_label = Label(
                self.input_frame, 
                text=text, 
                background=colorHeritageBlue,
                justify=RIGHT
            )

            semester_label.pack(
                side=TOP,
                fill=X,
            )

            semester_label.configure(
                font=fontGeorgia2, 
                fg=colorWhite,
            )

            semester_entry = Entry(
                self.input_frame
            )
            semester_entry.pack(
                side=TOP,
                fill=X,
                padx=5,
                pady=5
            )
            semester_entry.insert(0, "AA.XXX.XXX,")

            semesters[text] = {"label":semester_label, "entry":semester_entry}
            
        return semesters

    def enter_info(self):
        class_inputs = []
        for semester in self.semester_entries:
            sem_courses = re.split(",|,\n|, |\n| ", self.semester_entries[semester]['entry'].get().strip())
            class_inputs = class_inputs + sem_courses

        # fire function for calculations
        text_o = degree_calculations(class_inputs)

        self.out_label.config(text=text_o)

    def return_back(self):
        for semester in self.semester_entries:
            self.out_label.config(text="")
            self.semester_entries[semester]['entry'].delete(0, END)
            self.semester_entries[semester]['entry'].insert(0, "AA.XXX.XXX,")

root = Tk()
root.geometry("800x600")
root.protocol("WM_DELETE_WINDOW", callback)
root.wm_attributes("-transparentcolor", "yellow")
app = App(root)
root.mainloop()
