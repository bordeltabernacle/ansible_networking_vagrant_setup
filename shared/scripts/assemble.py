import os

files_dir = os.path.join(os.getcwd(), "output")
report_file = os.path.join(os.getcwd(), "reports", "serial_numbers.csv")



if os.path.exists(files_dir) and os.path.isdir(files_dir):
    with open(report_file, 'a') as fout:
        for csv_file in os.listdir(files_dir):
            with open(os.path.join(files_dir, csv_file)) as fin:
            
