import glob, os


file_list = [f for f in glob.glob("*.sv")]

print("Found those .sv files: ")
print(file_list)

fnd = raw_input("Enter string to find: ")
rplc = raw_input("And replace it with: ")

for f in file_list:
    with open(f, 'r') as file :
        filedata = file.read()

    filedata = filedata.replace(fnd, rplc)

    new_name = f.replace(fnd,rplc)
    with open(new_name, 'w') as file:
        file.write(filedata)
    
