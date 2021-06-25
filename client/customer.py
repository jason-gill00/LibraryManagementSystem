from tkinter import *
from tkinter import ttk
import customerquery as query
import cx_Oracle


class Customer:
    def __init__(self, root):
        self.root = root
        self.root.title("Customer")
        self.root.geometry("1000x450+0+0")
        self.root.config(bg="grey")

        # =============== Left Frame ==================
        frame1 = Frame(self.root, bg="white")
        frame1.place(x=0, y=0, width=500, height=450)
        title = Label(frame1, text = "LIBRARY", font=("times new roman", 20, "bold"), bg="white", fg="green").place(x=10, y=30)

        #=========== GenreLabel ===================
        MODES = [
            ("Romance", "Romance"),
            ("Action", "Action"),
            ("Comedy", "Comedy"),
            ("Adventure", "Adventure"),
            ("All", "All")
        ]

        genre_lbl = Label(frame1, text="Genre", font=("times new roman", 15, "bold"), bg="white", fg="gray").place(x=10, y=70)
        self.genre = StringVar()
        self.genre.set("All")
        print("THIS IS {}".format(self.genre))
        x=30
        y= 100
        for text, mode in MODES:
            Radiobutton(frame1, text=text, variable =self.genre, value=mode, bg="white", font=("times new roman", 14)).place(x=x, y=y)
            y+=22

        #============= Movie,book selection =======
        type_lbl = Label(frame1, text="Item Type", font=("times new roman", 15, "bold"), bg="white", fg="gray").place(x=10, y=214)
        self.type_select = StringVar()
        self.type_select.set("BOTH")
        self.r1= Radiobutton(frame1, text="Books", variable=self.type_select, value="BOOKS", bg="white", font=("times new roman", 14)).place(x=30, y=242)
        self.r2= Radiobutton(frame1, text="Videos", variable=self.type_select, value="VIDEOS", bg="white", font=("times new roman", 14)).place(x=30,y=264)
        self.r3= Radiobutton(frame1, text="Both", variable=self.type_select, value="BOTH", bg="white", font=("times new roman", 14)).place(x=30,y=285)

        #===========
        availability_lbl = Label(frame1, text="Availability", font=("times new roman", 15, "bold"), bg="white", fg="gray").place(x=10, y=307)
        self.availability = IntVar()
        Radiobutton(frame1, text="Available", variable=self.availability, value=1, bg="white", font=("times new roman", 14)).place(x=30, y=328)
        Radiobutton(frame1, text="Unavailable", variable=self.availability, value=2, bg="white", font=("times new roman", 14)).place(x=30,y=350)
        Radiobutton(frame1, text="All", variable=self.availability, value=3, bg="white", font=("times new roman", 14)).place(x=30,y=372)

        #================ Book Title ============
        book_title_lbl = Label(frame1, text="Item Title", font=("times new roman", 15, "bold"), bg="white", fg="gray").place(x=160, y=70)
        self.txt_user = Entry(frame1, font=("times new roman", 15), bg = "lightgray")
        self.txt_user.place(x=160, y=100, width = 250, height=30)

        #=========== Author
        author_lbl = Label(frame1, text="Author", font=("times new roman", 15, "bold"), bg="white", fg="gray").place(x=160, y=140)
        self.txt_author = Entry(frame1, font=("times new roman", 15), bg = "lightgray")
        self.txt_author.place(x=160, y=170, width = 250, height=30)

        #========= Item Number
        item_number_lbl = Label(frame1, text="Item Number", font=("times new roman", 15, "bold"), bg="white", fg="gray").place(x=160, y=210)
        self.txt_author = Entry(frame1, font=("times new roman", 15), bg = "lightgray")
        self.txt_author.place(x=160, y=240, width = 250, height=30)

        #============ Buttons
        reset_selection= Button(frame1, text="Reset Selection",fg="white", bg="#0B547C", font=("Arial", 15, "bold"), command = self.reset).place(x=160, y=290, width = 250, height=30)
        search= Button(frame1, text="Search Library",fg="white", bg="#0B547C", font=("Arial", 15, "bold"), command=self.search).place(x=160, y=340, width = 250, height=30)



        cols = ('Item #', 'Title', 'Genre', 'Availability', 'Rating')
        self.listBox = ttk.Treeview(root, columns=cols, show='headings')
        for col in cols:
            self.listBox.heading(col, text=col)
            self.listBox.column(col, minwidth=0, width=100, stretch=NO)
        self.listBox.place(x=510, y=100, width=480)


    def reset(self):
        self.genre.set("All")
        self.type_select.set("BOTH")

    def search(self):
        #print(self.genre.get(), self.type_select.get(), self.txt_user.get(), self.txt_author.get())
        dsnStr = cx_Oracle.makedsn("oracle.scs.ryerson.ca", "1521", "orcl")
        db = cx_Oracle.connect(user="j65gill", password="09260785", dsn=dsnStr)
        cursor = db.cursor()
        # genre_search = """
        #     SELECT l.ITEMID, l.GENRE, l.AVAILABILITYSTATUS, l.RATING
        #     FROM LIBRARYITEM L
        #     WHERE GENRE = '{}'
        # """.format(genre)


        if self.genre and self.type_select:
            print(self.genre.get(), self.type_select.get())
            if self.genre.get()!="All" and self.type_select.get()=="BOTH":
                print(self.genre.get(), self.type_select.get())
                print(self.type_select)
                #for i in self.listBox.get
                self.remove_all()
                genre = self.genre.get()
                cursor.execute(query.genre_search.format(genre))
                tables = cursor.fetchall()
                # for t in tables:
                #     print(t[1])
                for table in tables:
                    self.listBox.insert("", "end", values=(table[0],table[1], table[2], table[3], table[4]))
            elif self.type_select.get()!="BOTH" and self.genre.get()=="All":
                print(self.genre.get(), self.type_select.get())
                self.remove_all()
                type = self.type_select.get()
                print(type)
                cursor.execute(query.type_book.format(type))
                tables = cursor.fetchall()
                for table in tables:
                    self.listBox.insert("", "end", values=(table[0],table[1], table[2], table[3], table[4]))
            elif self.type_select.get()=="BOTH" and self.genre.get()=="All":
                self.remove_all()
                cursor.execute(query.all_books)
                tables = cursor.fetchall()
                for table in tables:
                    self.listBox.insert("", "end", values=(table[0],table[1], table[2], table[3], table[4]))

            else:
                self.remove_all()
                genre = self.genre.get()
                type = self.type_select.get()
                cursor.execute(query.genre_and_type.format(type, genre))
                tables = cursor.fetchall()
                for table in tables:
                    self.listBox.insert("", "end", values=(table[0],table[1], table[2], table[3], table[4]))

        # elif self.genre and self.type_select==None:
        #     print(self.type_select)
        #     #for i in self.listBox.get
        #     self.remove_all()
        #     genre = self.genre.get()
        #     cursor.execute(query.genre_search.format(genre))
        #     tables = cursor.fetchall()
        #     # for t in tables:
        #     #     print(t[1])
        #     for table in tables:
        #         self.listBox.insert("", "end", values=(table[0],table[1], table[2], table[3], table[4]))
        #
        # elif self.type_select and self.genre==None:
        #     self.remove_all()
        #     type = self.type_select.get()
        #     print(type)
        #     cursor.execute(query.type_book.format(type))
        #     tables = cursor.fetchall()
        #     for table in tables:
        #         self.listBox.insert("", "end", values=(table[0],table[1], table[2], table[3], table[4]))
        #
        #

    def remove_all(self):
        for record in self.listBox.get_children():
            self.listBox.delete(record)



root = Tk()
obj = Customer(root)
root.mainloop()
