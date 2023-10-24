This is template for writing SystemVerilog UVM UVCs.

Add code wherever needed for your UVC.

You can still use the runme script for running tests. Just pass your filelist as an argument to the script.

Included tests are extended test, that generates random number (between 100 and 150) of transactions. And asynchronous test (that performs a reset on the fly in random moment during 
simulation).

Support for "Reset on the fly" is included in drivers/monitors.

* * * Run find_replace_organize.py script. 
      It will replace word "temp" from template files with your desired word for uvc, create all folders and stort the files for you.
      For expample:
        you run the script and replace word "temp" with the word "apb".
        It will replace the word "temp" from existing files with the word "apb" and create a couple of new files called apb....sv ( for example apb_master_driver.sv, apb_monitor.sv etc)
        
