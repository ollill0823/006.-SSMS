/*

Hi Class,

Topic: IIF function

Question: Please select the customer id and state to determine 
if the customer lives in California from Addresses table 
*/


SELECT CustomerID, State,
    IIF(CustomerID = 'CA', 'Live in California', 'Not live in California') AS YesOrNoCheck

FROM Addresses