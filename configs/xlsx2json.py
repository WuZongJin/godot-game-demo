import argparse
import os
import shutil
import sys
import xlrd
import base64
import json
import re
import importlib

CONFIG_PATH = "./"
OUT_PUT_PATH = "./json_table/"
APP_TABLE_PATH = "app_json_table/"

CELL_TYPE_EMPTY = 0
CELL_TYPE_TEXT = 1
CELL_TYPE_NUMBER = 2
CELL_TYPE_DATE = 3
CELL_TYPE_BOOLEAN = 4
CELL_TYPE_ERROR = 5
CELL_TYPE_BLANK = 6

class LangConf:
    def __init__(self, lang, directory, colOffset):
        self.lang = lang
        self.directory = directory
        self.colOffset = colOffset

def convert(filename, name):
    print("Convertting file '{0}' ...".format(filename))

    workbook = xlrd.open_workbook(filename)
    sheetnames = workbook.sheet_names()
    outputfile = ""

    for sheetname in sheetnames:
        print("Converting sheet '{0}'...".format(sheetname))

        worksheet = workbook.sheet_by_name(sheetname)

        if worksheet.nrows < 2:
            print ("Mainformed sheet '{0}', at least 2 rows...".format(sheetname))
            return

        outputfile = os.path.join(OUT_PUT_PATH, name + ".json")
        with open(outputfile, "w") as fout:
            fout.write("{\n")
            fout.write("\"keys\":{")
            emptyCol = {}
            keys = {}
            flag = 0
            for j in range(0, worksheet.ncols):
                celltype = worksheet.cell_type(1, j)
                cellvalue = worksheet.cell_value(1, j)
                if celltype == CELL_TYPE_TEXT:
                    cellvalue = cellvalue
                elif celltype == CELL_TYPE_NUMBER:
                    num = int(cellvalue)
                    if num == cellvalue:
                        cellvalue = num
                else:
                    cellvalue = ""
                    emptyCol[j] = True
                if flag == 0:
                    fout.write("\"{0}\":{1}".format(cellvalue, flag))
                else :
                    fout.write(", \"{0}\":{1}".format(cellvalue, flag))
                flag = flag + 1
                keys[j] = "\"{0}\"".format(cellvalue)
            fout.write("}, \n")

            fout.write("\"rows\":{\n")
            for i in range(2, worksheet.nrows):
                flag = 0
                for j in range(0, worksheet.ncols):
                    if emptyCol.get(j, False):
                        continue
                    celltype = worksheet.cell_type(i, j)
                    cellvalue = worksheet.cell_value(i, j)
                    if celltype == CELL_TYPE_EMPTY:
                        cellvalue = "\"\""
                        cellvalueStr = "\"\""
                    elif celltype == CELL_TYPE_TEXT:
                        cellvalue = cellvalue.encode("utf-8")
                        cellvalueStr = "\"{0}\"".format(cellvalue)
                        cellvalue = cellvalueStr
                    elif celltype == CELL_TYPE_NUMBER:
                        num = int(cellvalue)
                        if num == cellvalue:
                            cellvalue = num
                            cellvalue = cellvalue
                        cellvalueStr = "\"{0}\"".format(cellvalue)
                    else:
                        print("sheet '{0}' containes invaildcell at {1} {2}".format(sheetname, i, j))
                        celltype = "\"\""
                    if flag == 0:
                        fout.write("{0}:[{1}".format(cellvalueStr, cellvalue))
                    else :
                        fout.write(", {0}".format(cellvalue))
                    flag = flag + 1
                if i == worksheet.nrows - 1:
                    fout.write("]\n")
                else :
                    fout.write("], \n")
            fout.write("}\n")
            fout.write("}\n")

def colorep(matched):
    value = matched.group(1)
    return '<font color = #' + value + '>'

if __name__ == '__main__':
    parse = argparse.ArgumentParser(description="convert xlsx to json")
    parse.add_argument("-f", "--file")
    args = parse.parse_args()

    if os.path.exists(OUT_PUT_PATH):
        shutil.rmtree(OUT_PUT_PATH)
    os.mkdir(OUT_PUT_PATH)

    if args.file:
        convert(args.file)
    else:
        for filename in os.listdir(CONFIG_PATH):
            name, ext = os.path.splitext(filename)
            if ext == ".xls" or ext == ".xlsx":
                convert(CONFIG_PATH + filename, name)
