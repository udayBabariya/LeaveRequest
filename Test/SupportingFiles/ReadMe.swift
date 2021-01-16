//
//  ReadMe.swift
//  Test
//
//  Created by Rahul Sharma on 15/01/21.
//

/*

 - https://api.bnscolorama.co.uk/employee_leave_CL_SL_PL_LWP_Request_1.php

 User below static param for request
 
 employee_id : 1503
 company_id : CO111020190001
 first_name: Vinay
 last_name : Patel
 employee_code: E824

 Date format - dd-mm-yyyy
 Value for half_day_Type  should be - Full / 1st Half / 2nd Half
 Value for day_Type  should be Full / Half
 Leave Type should be - PL / SL/ CL / LWP


 parameter == [

 "employee_id": 1503,
  "end_date": 23-12-2020,
 "reason": Test,
 "company_id": CO111020190001,
 "start_date": 16-12-2020,
 "leave_type": PL,
 "last_name": Patel,
  "leave_days": [
   {
     "date" : "16-12-2020",
     "day_type" : "Full",
     "half_day_type" : "Full"
   },
   {
     "date" : "17-12-2020",
     "day_type" : "Half",
     "half_day_type" : "1st Half"
   }
 ],
 "first_name": Vinay ,
 "employee_code": E824]

  

 Leave validation -
 PL should be in future date
 SL / CL must not selected for future date
 LWP can be any date.
 Please check for Sandwich leave. ( Not necessary)

  

 Validation
 - Leave type should be selected before request
 - Reason must not be empty
 - Start date and end date must not be empty.
 - Choose day leave must be selected.
 - Total leave days must be count while selecting leave type

 Example : if I selected 2 full days and I half day leave than total leave days must be 2.5
 Notes: On reset button all selection should be clear.
 */
