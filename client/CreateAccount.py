from tkinter import *
from tkinter import ttk
from PIL import ImageTk, Image
from tkinter import messagebox
import cx_Oracle


class CreateAccount:

    def __init__(self, root):
        self.root = root
        self.root.title("Create an Account")
        self.root.geometry("1350x700+0+0")
        self.root.config(bg="white")

        #======== BG image ===============
        path_to_file = "E:/School/Python/Tkinter/CPSPROJECT/home-libraries-0516-AD-KOTU05-01.jpg"
        self.bg=ImageTk.PhotoImage(Image.open(path_to_file))
        self.bg_image = Label(self.root, image=self.bg).place(x=0, y=0, relwidth=1, relheight=1)

        #========== Left Image =======wood-blue-dark-texture-background-159513483.jpg
        path_to_left = "E:/School/Python/Tkinter/CPSPROJECT/bluewood.jpg"
        self.left_pic=ImageTk.PhotoImage(Image.open(path_to_left))
        left = Label(self.root, image=self.left_pic).place(x=135, y=100, width=400, height=500)

        #========== Register Freame =======
        frame1 = Frame(self.root, bg="white")
        frame1.place(x=535, y=100, width=700, height=500)

        title = Label(frame1, text = "REGISTER HERE", font=("times new roman", 20, "bold"), bg="white", fg="green").place(x=50, y=30)

        sign_in_btn = Button(self.root, text="Sign In", fg="white", bg="#0B547C", font=("Arial", 15, "bold"), command = self.sign_in).place(x=200, y=500, width=250, height=40)

        first_name_lbl = Label(frame1, text="First Name", font=("times new roman", 15, "bold"), bg="white", fg="gray").place(x=50, y=100)
        self.first_name = Entry(frame1, font=("times new roman", 15), bg = "lightgray")
        self.first_name.place(x=50, y=130, width=250)

        last_name_lbl = Label(frame1, text="Last Name", font=("times new roman", 15, "bold"), bg="white", fg="gray").place(x=370, y=100)
        self.last_name = Entry(frame1, font=("times new roman", 15), bg = "lightgray")
        self.last_name.place(x=370, y=130, width=250)

        street_lbl = Label(frame1, text="Street Name", font=("times new roman", 15, "bold"), bg="white", fg="gray").place(x=50, y=170)
        self.street = Entry(frame1, font=("times new roman", 15), bg = "lightgray")
        self.street.place(x=50, y=200, width=250)

        city_lbl = Label(frame1, text="City", font=("times new roman", 15, "bold"), bg="white", fg="gray").place(x=370, y=170)
        self.city = Entry(frame1, font=("times new roman", 15), bg = "lightgray")
        self.city.place(x=370, y=200, width=250)


        province_lbl = Label(frame1, text="Province", font=("times new roman", 15, "bold"), bg="white", fg="gray").place(x=50, y=230)
        self.province = Entry(frame1, font=("times new roman", 15), bg = "lightgray")
        self.province.place(x=50, y=260, width=250)

        country_lbl = Label(frame1, text="Country", font=("times new roman", 15, "bold"), bg="white", fg="gray").place(x=370, y=230)
        self.country = Entry(frame1, font=("times new roman", 15), bg = "lightgray")
        self.country.place(x=370, y=260, width=250)

        phonenumber_lbl = Label(frame1, text="Phone Number", font=("times new roman", 15, "bold"), bg="white", fg="gray").place(x=50, y=290)
        self.phonenumber = Entry(frame1, font=("times new roman", 15), bg = "lightgray")
        self.phonenumber.place(x=50, y=320, width=250)

        birthdate_lbl = Label(frame1, text="Birthdate", font=("times new roman", 15, "bold"), bg="white", fg="gray").place(x=370, y=290)
        self.birthdate = Entry(frame1, font=("times new roman", 15), bg = "lightgray")
        self.birthdate.place(x=370, y=320, width=250)

        email_lbl = Label(frame1, text="Email", font=("times new roman", 15, "bold"), bg="white", fg="gray").place(x=50, y=350)
        self.email = Entry(frame1, font=("times new roman", 15), bg = "lightgray")
        self.email.place(x=50, y=380, width=250)

        password_lbl = Label(frame1, text="Password", font=("times new roman", 15, "bold"), bg="white", fg="gray").place(x=370, y=350)
        self.password = Entry(frame1, font=("times new roman", 15), bg = "lightgray")
        self.password.place(x=370, y=380, width=250)

        create_account_btn= Button(frame1, text="Create Account",fg="white", bg="#0B547C", font=("Arial", 15, "bold"), command = self.create_account).place(x=200, y=440, width = 250, height=40)


    def create_account(self):
        print(self.first_name.get())
        insert_query = """
            INSERT INTO PERSON
            VALUES('{}','{}',{},'{}','{}','{}','{}','{}','{}')
        """.format(self.birthdate.get(), self.email.get(), self.phonenumber.get(), self.first_name.get(), self.last_name.get(), self.province.get(), self.city.get(), self.country.get(), self.street.get())

        print(insert_query)
        dsnStr = cx_Oracle.makedsn("oracle.scs.ryerson.ca", "1521", "orcl")
        db = cx_Oracle.connect(user="j65gill", password="09260785", dsn=dsnStr)
        cursor = db.cursor()
        cursor.execute(insert_query)
        db.commit()
        myresult = cursor.fetchall()
        for x in myresult:
            print(x)
        cursor.close()



#        INSERT ALL
# INTO person
# VALUES('01-FEB-1987','sean12@gmail.com',647123456,'sean','beasley','M1W1J5','Ontario','Toronto','Canada',123,'Jane St.')
# dsn_str = cx_Oracle.makedsn("oracle.scs.ryerson.ca", "1521", "orcl")
# db = cx_Oracle.connect(user="j65gill", password="09260785", dsn=dsnStr)



    def sign_in(self):
        self.root.destroy()
        import library







root = Tk()
obj = CreateAccount(root)
root.mainloop()
