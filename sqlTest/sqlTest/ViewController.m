//
//  ViewController.m
//  sqlTest
//
//  Created by Anon on 7/21/14.
//  Copyright (c) 2014 Anthony Castor. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSMutableArray *arrayOfPerson;
    sqlite3 *personDB;
    NSString *dbPathString;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    arrayOfPerson = [[NSMutableArray alloc]init];
    [[self myTableView]setDelegate:self];
    [[self myTableView]setDataSource:self];
    [self createOrOpenDB];
    
}

-(void)createOrOpenDB
{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *docPath = [path objectAtIndex:0];
    dbPathString = [docPath stringByAppendingPathComponent:@"persons.db"];
    char *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:dbPathString])
    {
        const char *dbPath = [dbPathString UTF8String];
        
        //create db here
        if (sqlite3_open(dbPath, &personDB)==SQLITE_OK) {
            //this part need permision on the system before it can create a table
            const char *sql_stml = "CREATE TABLE IF NOT EXISTS PERSONS (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, AGE INTEGER)";
            sqlite3_exec(personDB, sql_stml, NULL, NULL, &error);
            sqlite3_close(personDB);
            NSLog(@"Table has been created");
            

        }
        else
        {
            NSLog(@"Cant create a table ");
            NSLog(@"Hellow world %s", dbPath);
        }
    }
    else
    {
        NSLog(@"Database is already exist created %@", dbPathString);
    }
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem)];
    self.navigationItem.rightBarButtonItem = addButton;
    [self displayFunction];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger )section
{
    return [arrayOfPerson count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    Person *aPerson = [arrayOfPerson objectAtIndex:indexPath.row];
    cell.textLabel.text = aPerson.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", aPerson.age];
    
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addPersonButton:(id)sender
{
    
}


-(void)addNewItem
{
    char *error;
    if (sqlite3_open([dbPathString UTF8String], &personDB)==SQLITE_OK)
    {
        NSString *inserStml = [NSString stringWithFormat:@"INSERT INTO PERSONS(NAME,AGE) values ('%s','%d')",[self.nameField.text UTF8String],[self.ageField.text intValue]];
        const char *insert_stml = [inserStml UTF8String];
        //NSLog(@"SQL Exec %d",sqlite3_exec(personDB, insert_stml, NULL, NULL, &error)==SQLITE_OK);
        //add a new data
        if (sqlite3_exec(personDB, insert_stml, NULL, NULL, &error)== SQLITE_OK )
        {
            NSLog(@"Person added");
            Person *person = [[Person alloc]init];
            
            [person setName:self.nameField.text];
            [person setAge:[self.ageField.text intValue]];
            [arrayOfPerson addObject:person];
            
        }
        else
        {
            NSLog(@"Can't add new data");
            
        }
        sqlite3_close(personDB);
    }
    else
    {
        NSLog(@"not working");
    }
    [[self myTableView]reloadData];

}


- (IBAction)displayPersonButton:(id)sender
{
    [self displayFunction];
}

-(void)displayFunction
{
    sqlite3_stmt *statement;
    if (sqlite3_open([dbPathString UTF8String], &personDB)==SQLITE_OK)
    {
        [arrayOfPerson removeAllObjects];
        NSString *query_Sql = [NSString stringWithFormat:@"SELECT * FROM PERSONS"];
        const char *query_sql = [query_Sql UTF8String];
        if (sqlite3_prepare(personDB, query_sql, -1, &statement, NULL)== SQLITE_OK) {
            while (sqlite3_step(statement)==SQLITE_ROW)
            {
                NSString *name = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                NSString *ageString = [[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 2)];
                
                Person *person = [[Person alloc]init];
                [person setName:name];
                [person setAge:[ageString intValue]];
                
                [arrayOfPerson addObject:person];
                
            }
        }
    }
    [[self myTableView]reloadData];
}

- (IBAction)deletePersonButton:(id)sender
{
    [[self myTableView]setEditing:!self.myTableView.editing animated:YES];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [[self ageField]resignFirstResponder];
    [[self nameField]resignFirstResponder];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        Person *p = [arrayOfPerson objectAtIndex:indexPath.row];
        [self deleteData:[NSString stringWithFormat:@"DELETE FROM PERSONS WHERE name is '%s'", [p.name UTF8String]]];
        [arrayOfPerson removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void)deleteData:(NSString *)deleteQuery
{
    char *error;
    if (sqlite3_exec(personDB, [deleteQuery UTF8String], NULL, NULL, &error)!= SQLITE_OK)
    {
        NSLog(@"Person Deleted");
    }
}


@end
