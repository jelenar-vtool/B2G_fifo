This is template for writing SystemVerilog UVM UVCs.

Add code wherever needed to fullfill your specific needs.

Commands for running tests are in runTests.py file, you can copy them to your terminal to run specific test, or just start .py file and run all tests listed in there.

Included tests are extended test, that generates random number (between 100 and 150) of transactions. And asynchronous test (that performs a reset on the fly in random moment during 
simulation).

Support for "Reset on the fly" is included in drivers/monitors.

* * * Run findNreplace.py script. It will replace word "temp" from template files with your desired word for uvc.
    For expample:
        you run the script and replace word "temp" with the word "apb".
        It will replace the word "temp" from existing files with the word "apb" and create a couple of new files called apb....sv ( for example apb_master_driver.sv, apb_monitor.sv etc)
        You can then delete old temp files and write your code in newly created files to complete your UVC.
        
