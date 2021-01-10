
function(input, output, session) {
  
 output$stud <- renderText({
   if (input$yesno1 == "Sudah")
   {  print("Pilihlah Tab DECISION TREE untuk melakukan prediksi")}
   else {
     if (input$yesno2 == "Ya")
     {
       print("Pilihlah Tab SUPPORT VECTOR MACHINE untuk melakukan prediksi")
     }
     else { if (input$yesno2 == "Tidak")
     {print("Pilihlah Tab RANDOM FOREST untuk melakukan prediksi") } 
       else {print("Lengkapilah data Anda sebelum melakukan prediksi")}}
   }

 })

  
    output$secondSelection <- renderUI({
    selectInput('nmsla', 'Nama Sekolah',
                sort(unique(School2[School2$wilayah == input$wilayah, 
                                              "nmsla"])), 
                selected = "")
  })

  
  JurSVM = reactive({
    df <- data.frame(nemgroup=as.factor(input$nemgroup),
                     wilayah=as.factor(input$wilayah),
                     nmsla=as.factor(input$nmsla))
    t_fin <- testing6[c("nemgroup", "wilayah","nmsla")]
    df <- rbind(t_fin[1, ] , df)
    df2 <- df[-1,]
    
    df<- predict(SVM_jur, newdata = df2)
    return(list(df=df))
    
  }
  )
  
  JurRF = reactive({
    df <- data.frame(nemgroup=as.factor(input$nemgroup),
                     wilayah=as.factor(input$wilayah))
                     #nmsla=as.factor(input$nmsla2))
    t_fin <- training6[c("nemgroup", "wilayah")]
    df <- rbind(t_fin[1, ] , df)
    df2 <- df[-1,]
    
    df<- predict(ForestOfStudentJur,newdata = df2)
    return(list(df=df))
    
  }
  )
  
 
  

### IPK SVM ####  
  StudentDF =  reactive({
    df <- data.frame(nemgroup=as.factor(input$nemgroup),
                     wilayah=as.factor(input$wilayah),
                     nmjur=JurSVM()$df,
                     nmsla=as.factor(input$nmsla))
    t_fin <- testing4[c("nemgroup", "nmjur", "wilayah","nmsla")]
    df <- rbind(t_fin[1, ] , df)
    df <- df[-1,]
    
    
    return(list(df=df))
    
  }
  )
  
  ### IPK RF ####  
  StudentRF =  reactive({
    df <- data.frame(nemgroup=as.factor(input$nemgroup),
                     wilayah=as.factor(input$wilayah),
                     nmjur=JurRF()$df)
    t_fin <- testing4[c("nemgroup", "nmjur", "wilayah")]
    df <- rbind(t_fin[1, ] , df)
    df <- df[-1,]
    
    
    return(list(df=df))
    
  }
  )
  
  ### IPK RT ####  
  StudentRT =  reactive({
    df <- data.frame(nemgroup=as.factor(input$nemgroup),
                     wilayah=as.factor(input$wilayah),
                     nmjur=as.factor(input$nmjur),
                     nmsla=as.factor(input$nmsla))
    t_fin <- testing4[c("nemgroup", "nmjur", "wilayah","nmsla")]
    df <- rbind(t_fin[1, ] , df)
    df <- df[-1,]
    
    
    return(list(df=df))
    
  }
  )
 
## semester SVM #### 
  SmtDF =  reactive({
    df3 <- data.frame(nemgroup=as.factor(input$nemgroup),
                      wilayah=as.factor(input$wilayah),
                      nmjur=JurSVM()$df,
                      nmsla=as.factor(input$nmsla))
    
    
    t_fin2 <- testing5[c("nemgroup", "nmjur", "wilayah", "nmsla")]
    
    df3 <- rbind(t_fin2[1, ] , df3)
    df3 <- df3[-1,]
    
    return(list(df3=df3))
    
    
  } )
  
  
  ## semester RF #### 
  SmtRF =  reactive({
    df3 <- data.frame(nemgroup=as.factor(input$nemgroup),
                      wilayah=as.factor(input$wilayah),
                      nmjur=JurRF()$df)
    
    
    t_fin2 <- testing5[c("nemgroup", "nmjur", "wilayah")]
    
    df3 <- rbind(t_fin2[1, ] , df3)
    df3 <- df3[-1,]
    
    return(list(df3=df3))
    
    
  } )
  
  ## semester RT #### 
  SmtRT =  reactive({
    df3 <- data.frame(nemgroup=as.factor(input$nemgroup),
                      wilayah=as.factor(input$wilayah),
                      nmjur=as.factor(input$nmjur),
                      nmsla=as.factor(input$nmsla))
    
    
    t_fin2 <- testing5[c("nemgroup", "nmjur", "wilayah", "nmsla")]
    
    df3 <- rbind(t_fin2[1, ] , df3)
    df3 <- df3[-1,]
    
    return(list(df3=df3))
    
    
  } )
  
  
  output$table13<- renderTable({
    
    print(JurSVM()$df)
    #jur_svm <- predict(SVM_jur,newdata = JurDF()$df)
   # print(jur_svm)
  }
  , 'include.rownames' = FALSE, 'include.colnames' = FALSE
  )

  output$table14<- renderTable({
    
    print(JurRF()$df)
    #jur_svm <- predict(SVM_jur,newdata = JurDF()$df)
    # print(jur_svm)
  }
  , 'include.rownames' = FALSE, 'include.colnames' = FALSE
  )
  
  output$table15<- renderTable({
    
    print(JurRT()$df)
    #jur_svm <- predict(SVM_jur,newdata = JurDF()$df)
    # print(jur_svm)
  }
  , 'include.rownames' = FALSE, 'include.colnames' = TRUE
  )
  
  output$table2 <- renderTable({print(StudentDF()$df)
  }
  , 'include.rownames' = FALSE, 'include.colnames' = FALSE
  )
  
  output$tableRF <- renderTable({print(StudentRF()$df)
  }
  , 'include.rownames' = FALSE, 'include.colnames' = FALSE
  )
  
  output$tableRT <- renderTable({print(StudentRT()$df)
  }
  , 'include.rownames' = FALSE, 'include.colnames' = FALSE
  )
  
  output$table3 <- renderTable({
    
    ipk <- predict(ForestOfStudent499a,
                   newdata = StudentRF()$df,
                   type = "response")
    
    print(ipk)
    
    
  }
  , 'include.rownames' = FALSE, 'include.colnames' = FALSE
  )
  
  
  output$table4 <- renderTable({
    
    ipk_lin <- predict(SVM_lin,
                       newdata = StudentDF()$df)
    
    print(ipk_lin)
    
  }
  , 'include.rownames' = FALSE, 'include.colnames' = FALSE
  )
  
  
  output$table6 <- renderTable({
    
    ipk_rt <- predict(optimal_tree,
                      newdata = StudentRT()$df)
    
    print(ipk_rt)
    
  }
  , 'include.rownames' = FALSE, 'include.colnames' = FALSE
  )
  
  
  output$table7 <- renderTable({
    
    semester_rf <- predict(ForestOfStudentS1,
                           newdata = SmtRF()$df3,
                           type = "response")
    
    print(semester_rf)
    
    
  }
  , 'include.rownames' = FALSE, 'include.colnames' = FALSE
  )
  
  output$table12 <- renderTable({
    
   
    
    semester_svm <- predict(SVM_sem,
                            newdata = SmtDF()$df3)
    
    print(semester_svm)
   
    
  }
  , 'include.rownames' = FALSE, 'include.colnames' = FALSE
  )
  
  output$table8 <- renderTable({
    
    semester_ct <- predict(ct_model,
                           newdata = SmtRT()$df3)
    
    #print(semester_ct)
    colnames(semester_ct)[apply(semester_ct,1,which.max)]
    
  }
  , 'include.rownames' = FALSE, 'include.colnames' = FALSE
  )
  output$txtout <- renderText({
    paste(input$txt)
  })
  
  output$txtout2 <- renderText({
    paste(input$txt, input$txt4, sep = ",  ")
  })
  output$txtout3 <- renderText({
    paste(input$txt)
  })
 
  


}

