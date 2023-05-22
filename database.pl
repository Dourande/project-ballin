#!/usr/bin/perl

use strict;
use warnings;

my $CONTACT_FILE = "contacts.txt";

sub print_menu {
    print "1. Search\n";
    print "2. Add\n";
    print "3. Delete\n";
    print "4. Modify\n";
    print "5. Menu\n";
    print "6. Exit\n";
}

sub search_record {
    print "Which criteria would you like to search by?\n";
    print "1. Name\n";
    print "2. Home Address\n";
    print "3. Phone Number\n";
    print "4. Email\n";
    print "5. ID\n";
    print "Enter your choice: ";
    my $search_choice = <STDIN>;
    chomp $search_choice;

    my $result;
    my $search_query;

    if ($search_choice == 1) {
        print "Enter the name to search for: ";
        $search_query = <STDIN>;
        chomp $search_query;
        $result = `grep -i "^$search_query," "$CONTACT_FILE"`;
    } elsif ($search_choice == 2) {
        print "Enter the home address to search for: ";
        $search_query = <STDIN>;
        chomp $search_query;
        $result = `grep -i ",$search_query," "$CONTACT_FILE"`;
    } elsif ($search_choice == 3) {
        print "Enter the phone number to search for: ";
        $search_query = <STDIN>;
        chomp $search_query;
        $result = `grep -i ",$search_query\$" "$CONTACT_FILE"`;
    } elsif ($search_choice == 4) {
        print "Enter the email to search for: ";
        $search_query = <STDIN>;
        chomp $search_query;
        $result = `grep -i ",$search_query" "$CONTACT_FILE"`;
    } elsif ($search_choice == 5) {
        print "Enter the ID to search for: ";
        $search_query = <STDIN>;
        chomp $search_query;
        $result = `grep -iE "^$search_query,|,$search_query\$" "$CONTACT_FILE"`;
    } else {
        print "Invalid choice\n";
        return;
    }

    if ($result) {
        print "Contact found\n";
        print "$result\n";
    } else {
        print "Contact not found\n";
    }
}

sub add_record {
    print "Please enter the following:\n";
    print "Name: ";
    my $name = <STDIN>;
    chomp $name;
    print "Home Address: ";
    my $address = <STDIN>;
    chomp $address;
    print "Phone Number: ";
    my $phone = <STDIN>;
    chomp $phone;
    print "Email: ";
    my $email = <STDIN>;
    chomp $email;
    print "ID (4 digits): ";
    my $id = <STDIN>;
    chomp $id;
    if ($id !~ /^\d{4}$/) {
        print "Invalid ID format. Please enter a 4-digit number\n";
        return;
    }
    print "Uploading info...\n";
    sleep 2;
    open(my $fh, '>>', $CONTACT_FILE) or die "Could not open file '$CONTACT_FILE' $!";
    print $fh "$name,$address,$phone,$email\n";
    close($fh);
    print "Contact added successfully\n";
}

sub delete_record {
    print "Enter the name of the contact to delete: ";
    my $name =
    <STDIN>;
    chomp $name;

    open(my $in_fh, '<', $CONTACT_FILE) or die "Could not open file '$CONTACT_FILE' $!";
    my @lines = <$in_fh>;
    close($in_fh);

    my $found = 0;
    open(my $out_fh, '>', $CONTACT_FILE) or die "Could not open file '$CONTACT_FILE' $!";
    foreach my $line (@lines) {
        my ($contact_name) = split(',', $line);
        if (lc($contact_name) eq lc($name)) {
            $found = 1;
            next;
        }
        print $out_fh $line;
    }
    close($out_fh);

    if ($found) {
        print "Contact deleted successfully\n";
    } else {
        print "Contact not found\n";
    }
}

sub modify_record {
    print "Enter the name of the contact to modify: ";
    my $name = <STDIN>;
    chomp $name;

    open(my $in_fh, '<', $CONTACT_FILE) or die "Could not open file '$CONTACT_FILE' $!";
    my @lines = <$in_fh>;
    close($in_fh);

    my $found = 0;
    open(my $out_fh, '>', $CONTACT_FILE) or die "Could not open file '$CONTACT_FILE' $!";
    foreach my $line (@lines) {
        my ($contact_name) = split(',', $line);
        if (lc($contact_name) eq lc($name)) {
            $found = 1;
            print "Current contact details:\n";
            print "$line\n";
            print "Enter the new name (leave blank to keep current name): ";
            my $new_name = <STDIN>;
            chomp $new_name;
            print "Enter the new home address (leave blank to keep current address): ";
            my $new_home = <STDIN>;
            chomp $new_home;
            print "Enter the new phone# (leave blank to keep the current phone#): ";
            my $new_phone = <STDIN>;
            chomp $new_phone;
            print "Enter the new email address (leave blank to keep the current email): ";
            my $new_email = <STDIN>;
            chomp $new_email;
            print "Enter the new ID (4 digits): ";
            my $new_ID = <STDIN>;
            chomp $new_ID;

            if ($new_email eq "") {
                $new_email = (split(',', $line))[1];
            }
            if ($new_phone eq "") {
                $new_phone = (split(',', $line))[2];
            }

            print $out_fh "$new_name,$new_home,$new_phone,$new_email\n";
            print "Modifying contact...\n";
            sleep 5;
            print "Contact modified successfully\n";
        } else {
            print $out_fh $line;
        }
    }
    close($out_fh);

    if (!$found) {
        print "Contact not found\n";
    }
}

print "Welcome to Ballin Employee Registration Database app v1!\n";

print_menu();

my $choice;
do {
    print "Enter your choice: ";
    $choice = <STDIN>;
    chomp $choice;

    if ($choice == 1) {
        search_record();
    } elsif ($choice == 2) {
        add_record();
    } elsif ($choice == 3) {
        delete_record();
    } elsif ($choice == 4) {
        modify_record();
    } elsif ($choice == 5) {
        print_menu
    } else {
        exit 0;
    }
    print "What else would you like to do?\n";
    print_menu();
} while ($choice != 6);

