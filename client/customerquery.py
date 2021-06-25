################# Genre #################
#Search genre
genre_search = """
    SELECT l.ITEMID, b.TITLE, l.GENRE, l.AVAILABILITYSTATUS, l.RATING
    FROM LIBRARYITEM l
    JOIN BOOKS b
        ON l.ITEMID = b.LIBRARYITEMNUMBER
    WHERE GENRE = '{}'
"""

#Search type
type_book = """
    SELECT l.ITEMID, b.TITLE, l.GENRE, l.AVAILABILITYSTATUS, l.RATING
    FROM LIBRARYITEM l
    JOIN {} b
        ON l.ITEMID = b.LIBRARYITEMNUMBER
"""
type_all = """
    SELECT l.ITEMID, b.BOOKTITLE, l.GENRE, l.AVAILABILITYSTATUS, l.RATING
    FROM LIBRARYITEM l
    JOIN {} b
        ON l.ITEMID = b.LIBRARYITEMNUMBER
"""

#=========== Genre and Type ===========

genre_and_type = """
    SELECT l.ITEMID, b.TITLE, l.GENRE, l.AVAILABILITYSTATUS, l.RATING
    FROM LIBRARYITEM l
    JOIN {} b
        ON l.ITEMID = b.LIBRARYITEMNUMBER
    WHERE GENRE = '{}'
"""

all_books = """
    SELECT l.ITEMID, b.TITLE, l.GENRE, l.AVAILABILITYSTATUS, l.RATING
    FROM LIBRARYITEM l
    JOIN BOOKS b
        ON l.ITEMID = b.LIBRARYITEMNUMBER
    UNION
    SELECT l.ITEMID, b.TITLE, l.GENRE, l.AVAILABILITYSTATUS, l.RATING
    FROM LIBRARYITEM l
    JOIN VIDEOS b
        ON l.ITEMID = b.LIBRARYITEMNUMBER
"""
