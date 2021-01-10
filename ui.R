#### NEW ###

navbarPage(
  theme = shinythemes::shinytheme("sandstone"),
  "Profiling Calon Mahasiswa UPH",
  
  tabPanel("Prediksi", 
           sidebarPanel(
             h4("Data Calon Mahasiswa"),
             h5("Silahkan masukan data calon mahasiswa yang akan dilakukan profiling:"),
             
             textInput("txt", "Nama:", "Nama"),
             
             selectInput('nemgroup', 
                         'Golongan Nilai Ebtanas Murni (NEM) / Nilai Ujian (UN) Nasional SMA',
                         sort(unique(IdentifiedStudent$nemgroup)), selected = "30.00-34.99"),
             
             selectInput('yesno1', 
                         'Apakah Anda sudah memiliki pilihan program studi?',
                         list(" ","Sudah", "Belum"), selected = " "),
             
             selectInput('wilayah', 'Provinsi Sekolah: ', sort(unique(IdentifiedStudent$wilayah)), selected = "Bali"),
             htmlOutput("secondSelection"),
             
             selectInput('yesno2', 
                         'Apakah nama sekolah Anda ada di dalam daftar?',
                         list(" ","Ya", "Tidak"), selected = " ")
            
             
           ),
            mainPanel(
              
              tabsetPanel(
               tabPanel("INFO",
                        h3("Aplikasi profiling calon mahasiswa UPH untuk memprediksi: "), 
                        h4("   - Program Studi "),
                        h4("   - IPK "),
                        h4("   - Lama Kuliah dalam Semester "),
                        
                        
                        br(),
                        h4("Prediksi dilakukan di tab algoritma machine learning: 
                      Support Vector Machine / Random Forest / 
                           Decision Tree dengan melengkapi data terlebih dahulu"),
                        br(),
                        textOutput('stud')
                    
                        ),
                 tabPanel("Support Vector Machine",
                         h2("Suport Vector Machine (SVM)"),
                         h5("Melakukan prediksi program studi, IPK, dan lama kuliah 
                            berdasarkan input berupa golongan nilai UN, provinsi sekolah, dan nama sekolah."),
                         h3("Profile dari:"),
                         verbatimTextOutput("txtout"),
                         tableOutput("table2"),
                         br(),
                         
                         h4("Berikut ini adalah tampilan prediksi menggunakan Support Vector Machine :"),
                         br(), 
                         
                         h4("Prediksi Program Studi: "),
                         tableOutput('table13'),
                         h4("Prediksi IPK terakhir: "),
                         tableOutput('table4'),
                         
                         h4("Prediksi lama kuliah (semester): "),
                         tableOutput("table12")
                         
                ),         
                
               tabPanel("Random Forest",
                        
                          h2("Random Forest"),
                          h5("Melakukan prediksi program studi, IPK, dan lama kuliah 
                             berdasarkan input berupa golongan nilai UN dan provinsi sekolah. 
                             Prediksi ini berguna untuk calon mahasiswa yang sekolahnya belum memiliki alumni yang telah lulus dari UPH.
                             "),
                        textInput('txt4', 
                                  'Nama Sekolah: (apabila di daftar tidak ada) ', 
                                  "SMA ..." ),
                          
                        h3("Profile dari:"),
                        verbatimTextOutput("txtout2"),
                        tableOutput("tableRF"),
                        
                          h4("Berikut ini adalah tampilan prediksi menggunakan Random Forest"),
                          
                          
                          h4("Prediksi Program Studi: "),
                          
                          tableOutput('table14'),
                          
                          
                          h4("Prediksi IPK terakhir: "),
                          tableOutput("table3"),
                          
                          h4("Prediksi lama kuliah (semester): "),
                          tableOutput("table7")
                          ) ,             
                        
               tabPanel("Decision Tree", 
                        
                        h2("Decision Tree"),
                        h5("Melakukan prediksi IPK dan lama kuliah 
                           berdasarkan input berupa golongan nilai UN, program studi, provinsi sekolah, dan nama sekolah. 
                           Prediksi ini berguna untuk calon mahasiswa yang sudah memiliki pilihan program studi 
                           dan ingin mengetahui prediksi keberhasilan studinya dari IPK dan lama kuliah"),
                      
                        
                        selectInput('nmjur', 'Pilihan Program Studi: ', sort(unique(IdentifiedStudent$nmjur)), selected = "AKUNTANSI"),
                        
                        h3("Profile dari:"),
                        verbatimTextOutput("txtout3"),
                        tableOutput("tableRT"),
                        br(),
                        h4("Berikut ini adalah tampilan prediksi menggunakan Decision Tree"),
                        br(),
                        
                        
                        h4("Prediksi IPK terakhir: "),
                        tableOutput("table6"),
                        
                        h4("Prediksi lama kuliah (semester): "),
                        tableOutput("table8")
                        
                        )
              )
            )
           
           ),
  
  
           tabPanel("Tentang", 
                    h1("Profiling Calon Mahasiswa UPH "),
                    h3("Menggunakan Random Forest, Support Vector Machine, dan Decision Tree"),
                    br(),
                    h4("Keterangan:"),
                    h5("- Golongan NEM/ Nilai UN: merupakan kelompok berdasarkan nilai dengan interval 5 poin "),
                    h5("- Pilihan program studi: program studi yang diinginkan di UPH"),
                    h5("- Provinsi Sekolah & Nama Sekolah: Pilih provinsi dan nama SMA asal"),
                    h5("- Prediksi IPK terakhir adalah IPK ketika lulus / berhenti kuliah dari UPH / pindah program studi"),
                    h5("- Lama kuliah: lama menempuh studi di UPH baik lulus/ pindah program studi/ berhenti kuliah. "),
                    h5("--- apabila menempuh >=8  dari itu mahasiswa sudah lulus"),
                    h5("--- apabila menempuh < 8 semester mahasiswa tidak lulus/ pindah program studi/ berhenti kuliah"),
                    
                    
                    br(),
                    h5("Dibuat oleh:"),
                      h4 ("Josephine"),
                      h5("Teknik Informatika 2016"),
                      h5 ("Universitas Pelita Harapan")
                    )
                    )
