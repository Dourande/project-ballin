#!/usr/bin/perl -w
#Project - contact database with Perl
#Version 0.2
#Use :%s/echo/print/ to replace echo with print for all line in vi

#reset # clear screen

# show menue function
sub print_menu{
  print "1. Search For a Record\n";
  print "2. Add New Employee\n";
  print "3. Delete a Record\n";
  print "4. Modify Employee Record\n";
  print "5. Exit\n";
}

# seach function 
sub search_record{
  print "We will search later on\n";
}

# add record to file
sub add_to_file{
  open(filehandle_w, '>>', 'contact_database_perl.dat') or die "Cannot open file: $!\n"; # $! conveys error message
  foreach $i (@_){
     print filehandle_w "$i\t";
  }
  print filehandle_w "\n";
  close(filehandle_w);

}
#show records
sub show_record{
  open(filehandle_r, '<', 'contact_database_perl.dat') or die "Cannot open file: $!\n"; # $! conveys error message
  while($line = <filehandle_r>){
     print $line;
     }
  close(filehandle_r);
}

# add function
sub add_record(){
  print "Name -> ";
  $id = <>; # we will test later if number
  chomp($id); #to remove newline character
  print "please enter full name -> ";
  $name = <>;  # we will test later if text
  chomp($name);
  print "please enter phone number -> ";
  $phone = <>; # we will test later if number
  chomp($phone);
  print "adding record to contact_database_perl.dat ...\n";
  add_to_file($id, $name, $phone);
  print "record added! displaying records: \n";
  show_record();
}

# delete function
sub delete_record(){
  print "We will delete later\n";
}

# modify function
sub modify_record(){
  print "We will modify later\n";
}

# program begins here
print "Welcome to Project Ballin Contact Database app v1!\n";
print "Please make a choice from the following menue!\n";
print_menu();    # call show meneu function
$choice = <>; # read choice
chomp($choice);

while ($choice != 5){     # loop as long as choice is not equal to 5
    if ($choice == 1){
         search_record();
    }
    elsif ($choice == 2){
         add_record();
    }
    elsif ($choice == 3 ){
         delete_record();
    }
    elsif ($choice == 4 ){
         modify_record();
    }
    else{
        exit 0
    }
    print "what else would you like to do, make a choice -> "; 
    $choice = <>;
}
