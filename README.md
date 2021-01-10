#PROFILING OF PROSPECTIVE STUDENTS FOR DETERMINING THE SUCCESS IN UPH USING SVM, RF, AND DT
Thesis Project

#ABSTRACT
High school students need to know their success of studies predictions at universities. 
To help them, profiling prospective students is needed in order to have sufficient information 
for the students to consider coming from the data they already have. 
This profiling is done using Machine Learning. 
This research was conducted using data from Pelita Harapan University’s (UPH) students.

Data gathering is the first step of this research, where data is structured of NIM, high school, NEM, study program, Units, and GPA. 
Second, data cleansing is done to remove incomplete record fields so it can be used for further processing. 
Third step is training data, the process of making models using Random Forest, SVM, and Decision Tree methods. 
Fourth step is prediction process using the models. 
The last is visualization results are the GPA predictions, study program, and length of study in semester.

This application can predict study program, GPA, and length of study by all method except Decision Tree without study program prediction. 
SVM predicts study program with more variation than Random Forest because of school name feature generalized to province in making Random Forest model. 
GPA prediction in SVM experiments tend to increase following the increasing of NEM compared to Random Forest which is still slightly up and down. 
Actual data from UPH alumni and Decision Tree GPA prediction from a most of experiment result show that 
actual GPA is higher than the prediction and length of study already match with the prediction. 
The evaluation results show that the most accurate GPA prediction is SVM, semester prediction is Random Forest, and study program prediction is SVM.
