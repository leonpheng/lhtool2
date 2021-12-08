#' Create Power point
#'
#'
#'@param  template Required typical template by Leon
#'@param  cover  Cover slide c("Title","Authors","Project No or Date").
#'@param  plain1 Slide with title c("zzz-yyy","Title") and single ggplot figure (C25/C75/C100), image (P25/P75/P100) or table (TAB). Sizes are 25%,75% and 100%.
#'@param  plain2 Slide with title c("zzz-yyy","Title") and combination of figure (Text or paragraph. For heading 1, 2 or 3 text c("text,1, 2 or 3)

#'@keywords ppt
#'@export
#'
#'@examples pres<-ppt()
#'@examples pres<-ppt(cover=c("title","authors","project number"))
#'@examples pres<-ppt(plain1=list(c("title","Title"),c("p","C100"));; p is ggplot
#'@examples pres<-ppt(plain2=list(c("title","Title"),c("p","CL"),c("t","TABR"),c("interpretation","TXT"));;t is table in flextable or data frame, L=left, R=right
#'@examples pres<-ppt(plain1=list(c("title","Title"),c("t","TAB"))
#'@examples print(pres,"testing.pptx")


ppt<-function(template="C:/Users/lpheng/Desktop/Templates and Documents/templateforofficer.pptx",cover=NULL,plain1=NULL,plain2=NULL){
  library(officer)
  library(flextable)

  if(is.null(c(cover,plain1,plain2))){
  pres <-read_pptx(template)
  pres<-pres%>%remove_slide(index=1)
  }

  officer::layout_properties(pres)
  if(!is.null(cover)){
    pres<-pres%>%
      add_slide(layout = "Cover", master = "certara officer")%>%
      ph_with(value = cover[1],
              location = ph_location_label(ph_label = "Title"))%>%
      ph_with(value = cover[2],
              location = ph_location_label(ph_label = "Authors"))%>%
      ph_with(value = cover[3],
              location = ph_location_label(ph_label = "Project"))}

  if(!is.null(plain1)&is.null(c(cover,plain2))){
    pres<-pres%>%add_slide(layout = "Plain1", master = "certara officer")
    for(x in 1:length(plain1)){
    if("Title"%in%plain1[[x]][2]){
    pres<-ph_with(pres,value =plain1[[x]][1],location = ph_location_label(ph_label ="Title"))
    }else{
    if(plain1[[x]][2]%in%c("TXTB","TXTL","TXTT")){
    pres<-ph_with(pres,value =plain1[[x]][1],location = ph_location_label(ph_label=plain1[[x]][2]))
    }else{
    if(plain1[[x]][2]%in%c("C25","C75","C100")){
                      a=plain1[[x]][1]
                        p=eval(parse(text=a))
                        pres<-ph_with(pres,value =p,location = ph_location_label(ph_label =plain1[[x]][2]))
    }else{
      if(plain1[[x]][2]%in%c("P25","P75","P100")){
        pres<-ph_with(pres,value =plain1[[x]][1],location = ph_location_label(ph_label =plain1[[x]][2]))
      }else{
        if(plain1[[x]][2]%in%c("TAB")){
          a=plain1[[x]][1]
          t=eval(parse(text=a))
          pres<-ph_with(pres,value =t,location = ph_location_label(ph_label =plain1[[x]][2]))
    }
      }}}}
    }}

    if(!is.null(plain2)){
      pres<-pres%>%add_slide(layout = "Plain2", master = "certara officer")
      for(x in 1:length(plain2)){
        if("Title"%in%plain2[[x]][2]){
          pres<-ph_with(pres,value =plain2[[x]][1],location = ph_location_label(ph_label ="Title"))
        }else{
          if(plain2[[x]][2]%in%c("TXT")){
            pres<-ph_with(pres,value =plain2[[x]][1],location = ph_location_label(ph_label=plain2[[x]][2]))
          }else{
            if(plain2[[x]][2]%in%c("CR","CL")){
              a=plain2[[x]][1]
              p=eval(parse(text=a))
              pres<-ph_with(pres,value =p,location = ph_location_label(ph_label =plain2[[x]][2]))
            }else{
              if(plain2[[x]][2]%in%c("PR","PL")){
                pres<-ph_with(pres,value =plain2[[x]][1],location = ph_location_label(ph_label =plain2[[x]][2]))
              }else{
                if(plain2[[x]][2]%in%c("TABR","TABL")){
                  a=plain2[[x]][1]
                  t=eval(parse(text=a))
                  pres<-ph_with(pres,value =t,location = ph_location_label(ph_label =plain2[[x]][2]))
                }
              }}}}
      }}
pres
}

#' Create word doc
#'
#'
#' @param template Document template if available, provide full path and template file name
#' @param df  Data frame will be converted by flextable table
#' @param tab Table created by flextable
#' @param txt Text or paragraph. For heading 1, 2 or 3 text c("text",1, 2 or 3)
#' @param img Plots saved as png. Enter the full path and file name
#' @param fig Plot created by ggplot
#'
#' @keywords wdoc
#' @export
#'@examples df<-data.frame(x=2,z=4)
#'@examples ft<-flextable(df)
#'@examples library(ggplot2)
#'@examples p<-ggplot(df,aes(x=x,y=z))+
#'@examples  geom_point()
#'
#'@examples doc<-NULL
#'@examples doc<-wdoc()
#'@examples doc<-wdoc(txt=c("this is a test",1))
#'@examples doc<-wdoc(df=df)
#'@examples doc<-wdoc(tab=ft)
#'@examples doc<-wdoc(fig=p)
#'@examples print(doc,"test.docx")
#'

wdoc<-function(template=NULL,df=NULL,tab=NULL,txt=NULL,img=NULL,fig=NULL){
  library(officer)
  library(flextable)
  if(is.null(df)&is.null(tab)&is.null(txt)&is.null(img)&is.null(fig)){
    if(is.null(template)){
    doc<-read_docx()
    }else{doc<-officer::read_docx(template)}}else{

if(!is.null(tab)){
    ftab<-width(tab, width=0.2)
    doc<-body_add_flextable(doc,tab)
  }

if(!is.null(df)&is.null(template)){
    ftab<-flextable(df)
    ftab<-width(ftab, width=0.2)
    doc<-body_add_flextable(doc,ftab)}

  if(!is.null(txt)){
    if(length(txt)==2){
      style1<-paste("heading",txt[2])
    doc<-body_add_par(doc,txt[1],style=style1)}else{doc<-body_add_par(doc,txt[1])}}
if(!is.null(img)){
  doc<-body_add_img(doc,img,width=6,height=6)}
  if(!is.null(fig)){
    doc<-body_add_gg(doc,fig,width=6,height=6)}}
  doc
}



#' Create define or data specification
#'
#' Verify if vector is varying or duplicate
#' @param lab data specification c(variable name;;label;;unit)
#' @keywords lh.def
#' @export
#'@examples lh.def(lab)

lh.def<-function (lab = c("code;;define;;unit", "b;;test>=b;;ug",
                          "c;;test<c;b;a;; "))
{
  def <- NULL
  for (i in 1:length(lab)) {
    splt<-strsplit(lab[i], ";;")[[1]]
    def <- rbind(def, data.frame(Variable = splt[1], Description = splt[2],
                                 Unit = splt[3]))
  }
  def$Unit[is.na(def$Unit)]<-""
  def
}


#' CHECK TIME VARYING OR DUPLICATE
#'
#' Verify if vector is varying or duplicate
#' @param data data frame
#' @param by Fixed or sorted vector (s)
#' @param var Vector (s) to be verified
#' @keywords lhtab1(data=df,sort.by=c("study","form"),cont=cont,cat=NULL,stats="stat1",fun="fun1",overall="yes",render="flex",transpose=F)
#' @export
#' @examples tab1<-lhtab1(data=dat1,sort.by="ARM",cont=continous,cat=categorical,render="word",overall="yes")
#'@examples print(tab1,"Demog.docx")

lhtime_var<-function(data,by="ID",var=c("BBILI","BILI")){
  tab<-NULL
  for(i in var){
    x<-nrow(dup2(nodup(data,c(by,i),"var"),by,"all"))
    z<-data.frame(variable=paste0(by[1],"~",i),Multiple=ifelse(x==0,"No","Yes"))
    tab<-rbind(tab,z)# BEGFR duplicate for this ID 282
  }
  tab}


#' Make Flexible table
#'
#' Generate descriptive statistic of continuous variable with style
#' @param table1 data frame
#' @keywords lhtab1(data=df,sort.by=c("study","form"),cont=cont,cat=NULL,stats="stat1",fun="fun1",overall="yes",render="flex",transpose=F)
#' @export
#' @examples tab1<-lhtab1(data=dat1,sort.by="ARM",cont=continous,cat=categorical,render="word",overall="yes")
#'@examples print(tab1,"Demog.docx")


lhflex<-function (table1, csv = "yes", bord = "yes", select = NULL, add.h = NULL,
          merge.all = "yes", size = 12, empty = NULL, cf = NULL, border = NULL,
          align = "center")
{
  library(flextable)
  library(dplyr)
  library(plyr)
  library(stringr)
  library(officer)
  b <- function(x) {
  }
  def_cell <- fp_cell(border = fp_border(color = "black"))
  std_b <- fp_border(color = "black")
  def_par <- fp_par(text.align = "center")
  def_text <- fp_text(color = "black", italic = F, font.family = "Time New Roman")
  def_text_header <- update(color = "black", def_text, bold = TRUE)
  if (!is.null(csv)) {
    if (!is.null(select)) {
      tab1 <- regulartable(table1, col_keys = select)
    }
    else {
      tab1 <- regulartable(table1)
    }
  }
  if (!is.null(empty)) {
    for (i in 1:ncol(table1)) {
      table1[, i][table1[, i] == "" | is.na(table1[, i])] <- empty
      table1
    }
  }
  else {
    table1
  }
  tab1 <- style(tab1, pr_t = def_text_header, part = "header")
  if (!is.null(add.h)) {
    if (!is.null(select)) {
      typology <- add.h
    }
    else {
      typology <- names(tab)
    }
    typology$col_keys <- select
    typology <- chclass(typology, names(typology), "char")
    tab1 <- set_header_df(tab1, mapping = typology, key = "col_keys")
    tab1 <- merge_h(tab1, part = "header")
    tab1 <- merge_v(tab1, part = "header")
  }
  tab1 <- style(tab1, pr_p = def_par, pr_t = def_text, part = "all")
  tab1 <- bg(tab1, bg = "gray88", part = "header")
  tab1 <- style(tab1, pr_t = def_text_header, part = "header")
  tab1 <- fontsize(tab1, size = size, part = "all")
  std_b2 <- fp_border(color = "black", style = "solid")
  std_b3 <- fp_border(color = "black", style = "dashed")
  if (!is.null(cf)) {
    for (xx in 1:length(cf)) {
      coord <- gsub(sub(".*:", ":", cf[xx]), "", cf[xx])
      fm <- gsub(sub(":.*", "", cf[xx]), "", cf[xx])
      fm <- gsub(sub(":.*", ":", fm), "", fm)
      if (length(grep("col", fm)) == 1) {
        vv <- gsub("col", "", fm)
        body(b) <- parse(text = paste("color(tab1,",
                                      coord, ",color=vv)"))
        tab1 <- b()
      }
      if (length(grep("mv", fm)) == 1) {
        vv <- gsub("mv", "", fm)
        body(b) <- parse(text = paste("merge_v(tab1,",
                                      coord, ")"))
        tab1 <- b()
      }
      if (length(grep("bg", fm)) == 1) {
        vv <- gsub("bg", "", fm)
        body(b) <- parse(text = paste("bg(tab1,", coord,
                                      ",bg=vv)"))
        tab1 <- b()
      }
      if (length(grep("mh", fm)) == 1) {
        vv <- gsub("mh", "", fm)
        body(b) <- parse(text = paste("merge_h(tab1,",
                                      coord, ")"))
        tab1 <- b()
      }
      if (length(grep("ma", fm)) == 1) {
        vv <- gsub("ma", "", fm)
        body(b) <- parse(text = paste("merge_at(tab1,",
                                      coord, ")"))
        tab1 <- b()
      }
      if (length(grep("bol", fm)) == 1) {
        vv <- gsub("bol", "", fm)
        body(b) <- parse(text = paste("bold(tab1,", coord,
                                      ",bold=TRUE)"))
        tab1 <- b()
      }
      if (length(grep("ita", fm)) == 1) {
        vv <- gsub("ita", "", fm)
        body(b) <- parse(text = paste("italic(tab1,",
                                      coord, ")"))
        tab1 <- b()
      }
    }
  }
  para <- fp_border(color = "black", style = "dashed")
  para1 <- fp_border(color = "black", style = "solid")
  tab1 <- border_remove(tab1)
  tab1 <- border_outer(tab1, border = para1, part = "all")
  tab1 <- border_inner_h(tab1, border = para1, part = "all")
  tab1 <- border_inner_v(tab1, border = para1, part = "all")
  if (!is.null(border)) {
    for (i in 1:length(border)) {
      ca <- gsub(sub(":.*", ":", border[i]), "", border[i])
      co1 <- gsub(ca, "", border[i])
      co1 <- gsub(":", "", co1)
      ca1 <- gsub(sub(":.*", ":", ca), "", ca)
      co2 <- gsub(ca1, "", ca)
      co2 <- gsub(":", "", co2)
      ca2 <- gsub(sub(":.*", ":", ca1), "", ca1)
      co3 <- gsub(ca2, "", ca1)
      co3 <- gsub(":", "", co3)
      ca3 <- gsub(sub(":.*", ":", ca2), "", ca2)
      co4 <- gsub(ca3, "", ca2)
      co4 <- gsub(":", "", co4)
      if (length(grep("out", co1)) == 1) {
        out <- fp_border(color = co3, style = co2)
        tab1 <- border_outer(tab1, border = out, part = co4)
      }
      if (length(grep("vi", co1)) == 1) {
        out <- fp_border(color = co3, style = co2)
        tab1 <- border_inner_v(tab1, border = out, part = co4)
      }
      if (length(grep("hi", co1)) == 1) {
        out <- fp_border(color = co3, style = co2)
        tab1 <- border_inner_h(tab1, border = out, part = co4)
      }
    }
    tab1 <- align(tab1, align = align, part = "all")
  }
  tab1 <- autofit(tab1)
}


#' Descriptive Statistics Continuous with Style
#'
#' Generate descriptive statistic of continuous variable with style
#' @param data dataset
#' @param sort.by sorting variables
#' @param cont list of continuous variables
#' @param cat list of categorical variables
#' @param stats statistic functions. stat1 contained most of basic statistic function (mean, median up to CI95). User can define personal list of function (ex: c("length(x)/mean(x)=RT"))
#' @param fun define the output
#' @param overall if the overall stats required then overall="yes"
#' @param render the output format as flexible table "flex", as "csv". Note that officer package is required for the word format and save the output as docx (ex: print(doc,"table1.docx))
#' @param format two formats available, stacked or not
#' @keywords lhtab1(data=df,sort.by=c("study","form"),cont=cont,cat=NULL,stats="stat1",fun="fun1",overall="yes",render="flex",transpose=F)
#' @export
#' @examples tab1<-lhtab1(data=dat1,sort.by="ARM",cont=continous,cat=categorical,render="word",overall="yes")
#'@examples print(tab1,"Demog.docx")


lhtab2<-function (data, sort.by = c("STUDYID","SEXC"), cont =c("ALT","BAST","AST"),
                  stats = c("length(x[!is.na(x)])=N","length(x[is.na(x)])=Nmiss", "geom(x)=GeoMean","median(x,na.rm=T)=Median","quantile(x,0.5,na.rm=T)=50thPI","mean(x,na.rm=T)=Mean","cv(x)=CV%","min(x)=Min","max(x)=Max","geocv(x)=GeoCV%"), stat.group = list(c("N", " (","Nmiss", ")"),c("Mean"," (","CV%",")"), c("Median"," [","Min",", ","Max","]"),c("GeoMean"," (","GeoCV%",")")),render = "flextable", overall = "yes",format="stacked")

{

  if (!is.null(overall)) {
    dataxxx <- data
    dataxxx[, sort.by] <- "Overall"
    #setdiff(names(dataxxx), names(data))
    data3 <- rbind(data, dataxxx)
  }else {
    data3 <- data
  }

  data3<-chclass(data3,cont,"num")

  sort(unique(data$HEPIMPC))


  t1 <- addvar2(data3, sort = sort.by, cont, stats)

  t1[,names(t1)=="Nmiss"]<-round(as.numeric(as.character(t1[,names(t1)=="Nmiss"])),0)


  if(format=="stacked"){
    t3<-NULL
    for(i in 1:length(stat.group)){
      t33<-t1
      t33$sum<-""
      t33$lab<-""
      for(ii in unlist(stat.group[i])){
        if(ii%in%names(t33)){
          t33$sum<-paste0(t33$sum,t33[,ii])
        }else{t33$sum<-paste0(t33$sum,ii)}
        t33$lab<-paste0(t33$lab,ii)
        t33$labsor<-i
      }
      t3<-rbind(t3,t33)
    }
  }else{
    t33<-t1
    t33$sum<-""
    t33$lab<-""
    for(i in 1:length(stat.group)){

      for(ii in unlist(stat.group[i])){
        if(ii%in%names(t33)){
          t33$sum<-paste0(t33$sum,t33[,ii])
        }else{t33$sum<-paste0(t33$sum,ii)}
        t33$lab<-paste0(t33$lab,ii)
        t33$labsor<-i
      }
      if(i<length(stat.group)){
        t33$sum<-paste0(t33$sum,"\n ")
        t33$lab<-paste0(t33$lab,"\n ")}else{
          t33$sum<-t33$sum
          t33$lab<-t33$lab
        }}
    t3<-t33}

  #SORT
  sby<-nodup(t3,sort.by,"all")
  sby$sort<-""
  sby<-sby[,c(sort.by,"sort")]
  for(iii in sort.by){
    sby$sort<-paste0(sby$sort,"-",sby[,iii])
  }
  t4<-left_join(t3,sby)
  s1<-sort(unique(t4[,sort.by[1]]))

  t4<-reflag(t4,sort.by[1],c(as.character(s1[s1!="Overall"]),"Overall"))
  t4<-t4[order(t4[,sort.by[1]]),]
  colord<-c("var","lab",unique(t4$sort))

  t5<-lhwide(t4[,c("var","labsor","lab","sort","sum")],"sum","sort")
  setdiff(colord,names(t5))
  t5<-t5[,c("labsor",colord)]

  keep<-unlist(names(t5))
  sby<-reflag(sby,"sort",keep)
  sby<-sby[order(sby$sort),]

  t5a<-t5[1:ncol(sby)-1,]
  for(t in 1:nrow(t5a)){
    t5a[t,]<-c("labsor","var","lab",as.character(unlist(sby[,t])))
  }

  if(render!="flextable"){
    if(format=="stacked"){

      t6<-stackvar(t5,c("var","lab"))
      t6$labsor<-NULL
      t6<-rbind(t5a[,names(t6)],t6)
      names(t6)<-t6[1,]}else{
        t6<-rbind(t5a[,names(t5)],t5)
      }
  }else{
    if(format=="stacked"){
      bold<-t5[,c("var","lab")]
      bold$row<-seq(nrow(bold))
      bold<-nodup(bold,"var","all")
      bold$row2<-seq(0,nrow(bold)-1,1)
      bold<-unlist(bold$row+bold$row2)
      t6<-stackvar(t5,c("var","lab"))
      t6$labsor<-NULL
      hd<-data.frame(t(t5a[,names(t6)]))
      row.names(hd)<-NULL
      t6<-lhflex(t6,select =names(t6),add.h=hd)
      t6 <- bold(t6, i = c(bold), j = "lab")
    }else{
      t6<-t5
      lab<-unique(t6$lab)
      t6$labsor<-t6$lab<-NULL
      hd<-data.frame(t(t5a[,names(t6)]))
      kn<-names(hd)
      hd$y<-lab
      hd$y[1]<-"var"
      hd<-hd[,c("y",kn)]
      row.names(hd)<-NULL
      t6<-lhflex(t6,select =names(t6),add.h=hd)
    }
  }
  t6
}




#' Descriptive Statistics Continuous and Discrete
#'
#' Generate descriptive statistic of continuous and/or categorical variables
#'
#' @param data dataset
#' @param sort.by sorting variables
#' @param cont list of continuous variables
#' @param cat list of categorical variables
#' @param stats statistic functions. stat1 contained most of basic statistic function
#' @param fun define the output
#' @param overall if the overall stats required then overall="yes"
#' @param render the output format as flexible table "flex", as "csv", or word document ("word"). Note that officer package is required for the word format and save the output as docx (ex: print(doc,"table1.docx))
#' @param transpose when transpose is TRUE, the output will be in docx containing both continuous and categorical covariate
#' @keywords lhtab1(data=df,sort.by=c("study","form"),cont=cont,cat=NULL,stats="stat1",fun="fun1",overall="yes",render="flex",transpose=F)
#' @export
#' @examples tab1<-lhtab1(data=dat1,sort.by="ARM",cont=continous,cat=categorical,render="word",overall="yes")
#'@examples print(tab1,"Demog.docx")


lhtab1<-function (data , sort.by = c("study", "form"), cont =NULL,
                  cat = c("Sex","Race"), stats = "stat1", fun = "fun1", overall = "yes",
                  render = "flex", transpose = F)
{
  N = "length(x[!is.na(x)])=N"
  Nmiss = "length(x[is.na(x)])=Nmiss"
  MEAN = "mean(x,na.rm=T)=MEAN"
  SD = "sd(x,na.rm=T)=SD"
  CV = "cv(x)=CV"
  GEOM = "geom(x)=GEOM"
  GEOCV = "geocv(x)=GEOCV"
  MEDIAN = "median(x,na.rm=T)=MEDIAN"
  MIN = "min(x,na.rm=T)=MIN"
  MAX = "max(x,na.rm=T)=MAX"
  QT025 = c("quantile(x,0.025,na.rm=T)=QT025")
  QT975 = c("quantile(x,0.975,na.rm=T)=QT975")
  QT05 = c("quantile(x,0.05,na.rm=T)=QT05")
  QT95 = c("quantile(x,0.95,na.rm=T)=QT95")
  CI95 = "ciup(x)=CI95"
  CI05 = "cilow(x)=CI05"
  stat1 = c(N, Nmiss, MEAN, CV, MEDIAN, MIN, MAX, GEOM, GEOCV,
            QT025, QT975, CI95, CI05, QT05, QT95)
  fun1 = c("MEAN", " (", "CV", ")\n ", "MEDIAN", " [", "MIN",
           ", ", "MAX", "]")

  fun2 = c("MEAN", " (", "CV", ")\n ", "MEDIAN", " [", "MIN",
           ", ", "MAX", "]\n", "GEOM", " (", "GEOCV", ")")

  if (stats == "stat1") {
    comp.stats = stat1
  } else {
    comp.stats = stats
  }
  if (fun == "fun1") {
    comp.fun = fun1
  } else {
    if (fun == "fun2") {
      comp.fun = fun2
    }    else {
      comp.fun = funx
    }
  }
  if (!is.null(overall)) {
    dataxxx <- data
    dataxxx[, sort.by] <- "Overall"
    setdiff(names(dataxxx), names(data))
    data3 <- rbind(data, dataxxx)
  }  else {
    data3 <- data
  }

  if (!is.null(cont)) {

    t1 <- addvar2(data3, sort = sort.by, cont, comp.stats)
    s2 <- sub(".*)=", "", stat1)
    t1$sum = ""
    title = ""
    for (i in comp.fun) {
      if (i %in% s2) {
        t1$sum = paste0(t1$sum, t1[, i])
      }   else {
        t1$sum = paste0(t1$sum, i)
      }
      title = paste0(title, i)
    }
    t1$nrow <- seq(nrow(t1))
    t1$x <- ""
    for (i in 1:length(sort.by)) {
      t1$x <- paste0(t1$x, "-", t1[, i])
    }
    head2 <- nodup(t1[, c(sort.by, "x")], sort.by, "all")
    t2 <- lhwide(t1[, c("var", "x", "sum")], "sum", "x")
  } else {
    t2 = NULL
  }

  if (!is.null(cat)) {
    dcat <- data
    dcat$sort <- ""
    for (i in sort.by) {
      dcat$sort <- paste0(dcat$sort, "-", dcat[, i])
    }
    dcat<-dcat[order(dcat$sort),]
    catheader <- nodup(dcat[, c(sort.by, "sort")], "sort",
                       "all")
    t11 <- lhcattab(dcat, cat, "sort")
    #head(t11)
    t11<-t11[,c("var","value",catheader$sort,"overall")]
    total<-addvar(dcat,"sort",cat,"length(x)","no","tot")
    #t11 <- t11[t11$var != "all", ]
    bold <- t11[, "var"]
    t111 <- t11
    headwide11 <- t11[, c("var", "value")]
    t11 <- stackvar(t11, c("var", "value"))
    row11 <- data.frame(x = t11[, c("value")], y = seq(nrow(t11)))
    row11 <- row11[row11$x %in% bold, "y"]
    if (!is.null(overall)) {
      t11 <- t11
      names(t11)[grep("overall", names(t11))] <- "tobereplaced"
    }  else {
      t11$overall <- NULL
    }
  } else {
    t11 <- NULL
  }

  if (!is.null(t2) & !is.null(t11)) {
    names(t11)[names(t11) == "tobereplaced"] <- names(t2)[grep("Overall",
                                                               names(t2))]
    names(t11)[names(t11) == "value"] <- "var"
    t11 <- t11[, names(t2)]
  } else {
    t11 <- t11
  }
  if (!is.null(cont)) {
    tx <- chclass(t1[, c(sort.by, "N", "x")], sort.by, "char")
    tx$N <- paste0("N=", tx$N)
    tx$tit <- title
    tx <- nodup(tx, c(sort.by), "all")
    tx <- tx[, c("tit", names(tx)[!names(tx) %in% "tit"])]
    txx <- tx[1, ]
    txx[1, ] <- "var"
    tx <- rbind(txx, tx)
    tx <- reflag(tx, "x", names(t2))
    tx$x <- as.character(tx$x)
    tx$x[grep("overall", tx$x)] <- "Overall"
    tx <- reflag(tx, "x", unique(tx$x))
    #tx <- tx[order(tx$x), ]
    tx$x <- NULL
  } else {
    tx <- chclass(catheader[, c(sort.by, "sort")], sort.by,
                  "char")
    tx$sort[grep("overall", tx$sort)] <- "Overall"
    tx$tit <- "N (%)"
    tx <- tx[, c("tit", names(tx)[!names(tx) %in% "tit"])]
    txx <- tx[1, ]
    txx[1, ] <- "var"
    if ("Overall" %in% names(t11) | "tobereplaced" %in% names(t11)) {
      txxx <- tx[1, ]
      txxx[1, ] <- "Overall"
      txxx[, "tit"] <- "N (%)"
    }  else {
      txxx <- NULL
    }
    tx <- rbind(txx, tx, txxx)
    tx1<-names(t11);tx1[tx1=="value"]<-"var";tx1[tx1=="tobereplaced"]<-"Overall"
    tx <- reflag(tx, "sort",tx1, tx1)
    tx <- tx[order(tx$sort), ]
    tx$sort <- NULL
  }
  if (!transpose) {
    tx[1, ] <- "Variable"
    t4 <- rbind(t2, t11)
    t3 <- lhflex(t4, select = names(t4), add.h = tx[1:length(names(t4)),
    ], size = 9)

    if (!is.null(t2)) {
      rowcon <- unlist(seq(nrow(t2)))
    } else {
      rowcon <- 0
    }
    if (!is.null(t11)) {
      rowcat <- row11
    } else {
      rowcat <- 0
    }
    if (!is.null(cont) & !is.null(cat)) {
      row12 <- c(rowcon, max(rowcon) + rowcat)
    } else {
      if (!is.null(cont) & is.null(cat)) {
        row12 <- c(rowcon)
      } else {
        row12 <- c(rowcat)
      }
    }
    t3 <- bold(t3, i = row12, j = NULL, bold = TRUE, part = "body")
    if (render == "csv") {
      t.render = t4
    } else {
      if (render == "word") {
        t.render <- read_docx() %>% body_add_flextable(t3) %>%
          body_add_break()
      } else {
        t.render = t3
      }
    }
  } else {
    t.render <- NULL
  }
  if (transpose & !is.null(cont)) {
    lon <- lhlong(t2, names(t2[, 2:ncol(t2)]))
    wid <- lhwide(lon[, c("variable", "value", "var")], "value",
                  "var")
    wid <- reflag(wid, "variable", head2$x)
    wid <- wid[order(wid$variable), ]
    variable <- head2[, 1]
    wid2 <- cbind(variable, wid[, 2:ncol(wid)])
    conttab <- lhflex(wid2, select = names(wid2), add.h = data.frame(x = c("variable",
                                                                           rep(title, ncol(wid2) - 1)), y = names(wid2)), size = 9)
    t.render <- read_docx() %>% body_add_flextable(conttab) %>%
      body_add_break()
  }else {
    conttab <- NULL
  }
  if (transpose & !is.null(cat)) {
    names(t111)[names(t111) == "value"] <- "var2"
    kn <- names(t111)
    t111$x <- ""
    for (i in c("var", "var2")) {
      t111$x <- paste0(t111$x, "-", t111[, i])
    }
    lon11 <- lhlong(t111[, c("x", kn)], names(t111[, c("x",
                                                       kn)])[4:ncol(t111)])
    kn1 <- nodup(lon11[, c("x", "var", "var2")], c("x", "var",
                                                   "var2"), "all")
    wid11 <- lhwide(lon11[, c("variable", "value", "x")],
                    "value", "x")
    wid11 <- wid11[, c("variable", kn1$x)]
    kn2 <- kn1[, c("var", "var2")]
    kn3 <- kn2[1, ]
    kn3[1, ] <- "variable"
    kn2 <- rbind(kn3, kn2)
    cattab <- lhflex(wid11, select = names(wid11), add.h = kn2,
                     size = 9, empty = 0)
  }else {
    cattab <- NULL
  }
  if (transpose & !is.null(cat) & !is.null(cont)) {
    t.render <- read_docx() %>% body_add_flextable(conttab) %>%
      body_add_break() %>% body_add_flextable(cattab)
  }else {
    if (transpose & !is.null(cont)) {
      t.render <- read_docx() %>% body_add_flextable(conttab)
    } else {
      if (transpose & !is.null(cat)) {
        t.render <- read_docx() %>% body_add_flextable(cattab)
      } else {
        t.render
      }
    }
  }
  t.render
}

#' Cut values and create category
#'
#' @param data Data frame
#' @param var Variable to be cut
#' @param breaks break points
#' @param labels category name. If fancy, the categories will be created according to the break points
#' @param right If false, right value will be exclusive
#'  @param newvar vector name of the categorical. If default, the var with suffix"cat" will be used as default name
#' @keywords lhcut()
#' @export


lhcut<-function(data,var="AGE",breaks=c(20,40,60),labels="fancy",right=F,newvar="default"){
  brk=c(min(data[,var]),breaks,max(data[,var])^2)
  if(newvar=="default"){nvar=paste0(var,"cat")}else{nvar=newvar}
  if(labels=="fancy"){
    lab1=c(paste0("<",breaks))
    lab2<-c(paste0(">=",breaks))
    lab3<-c(paste0("<=",breaks))
    lab4<-c(paste0(">",breaks))
    lab11<-NULL;lab22<-NULL
    for(i in 1:(length(breaks)-1)){
      lab11<-c(lab11,paste(lab2[i],"&",lab1[i+1]))
      lab22<-c(lab22,paste(lab4[i],"&",lab3[i+1]))
    }
    if(right){
      labels1<-c(lab3[1],lab22,lab4[length(lab4)])}else{
        labels1<-c(lab1[1],lab11,lab2[length(lab2)])
      } }else{labels1=labels}

  data[,nvar]<-cut(data[,var],breaks=brk,labels=labels1,right=right)
  print(addvar(data,nvar,var,"range(x)","no"))
  data}


#' Change factor level of a variable using matched level of another variable in the same dataset
#'
#' @param data Data frame
#' @param leader lead Variable to be used for factor level of the follower variable
#' @param follower follower Variable
#' @keywords lhfactor()
#' @export


lhfactor<-function(data,leader="AGEcat",follower="catt"){
  lab<-nodup(data,c(leader,follower),"var");lab<-lab[order(lab[,leader]),follower]
  data<-reflag(data,follower,lab)
}




#' Combine variables in the same column
#'
#' @param data Data frame 1 and 2 with long vectors and values. Note: no duplicated sorting vector allowed
#' @param combine.var Variable name, c(var1,var2). var1 will be stacked over var 2
#' @keywords stackvar()
#' @export

stackvar<-function(data,combine.var=c("xxx","variable")){
  z=data
  z$dum <- seq(nrow(z))
  z1 <- z
  z1$dum <- z1$dum - 1
  z1 <- nodup(z1, combine.var[1], "all")
  keep <- c(combine.var[1], combine.var[2], "dum")
  z1[, combine.var[2]] <- z1[, combine.var[1]]
  z1[, !names(z1) %in% keep] <- ""
  z <- rbind(z, z1[, names(z)])
  z <- z[order(z$dum), ]
  z[, c(combine.var[1], "dum")] <- NULL
  z
  }




#' mutate variable names
#'
#' @param data Data frame 1 and 2 with long vectors and values. Note: no duplicated sorting vector allowed
#' @param mutate Vector to be mutated ex. "xxx=yyy" for renaming xxx as yyy
#' @keywords lhmutate()
#' @export

lhmutate<-function(data,mutate){
  keep<-sub("=.*","",mutate)%in%names(data)
  imp<-sub(".*=","",mutate)[keep]
  bimp<-sub("=.*","",mutate)[keep]
  print(c("Not found:",sub("=.*","",mutate)[!sub("=.*","",mutate)%in%names(data)]))

  for(i in 1:length(bimp)){
    names(data)[names(data)==bimp[i]]<-imp[i]
  }
  data
}




#' Reshape wide
#'
#' @param data Dataset
#' @param wide.data Name of vector containing data to be dcasted
#'  @param wide.vector Name of vector to be reshape as heading
#' @param data Dataset
#' @keywords lhwide()
#' @export
#' @examples lhwide()

lhwide<-function(data,wide.data,wide.vector){
  data<-data[,c(names(data)[!names(data)%in%c(wide.data,wide.vector)],wide.vector,wide.data)]
  b <- function(x) {}
  x1<-paste(paste(names(data)[!names(data)%in%c(wide.data,wide.vector)],collapse="+"),"~",wide.vector)
  body(b) <- parse(text = x1)
  z1<-reshape2::dcast(data,b())}

#' Reshape long
#'
#' @param data Dataset
#' @param long.vector List of vector to be melted
#'
#' @keywords lhlong()
#' @export
#' @examples lhlong()

lhlong<-function(data,long.vector){
  z1<-reshape2::melt(data,names(data)[!names(data)%in%long.vector])
}


#' find different values between two datasets
#'
#' @param dat1 Data frame 1
#' @param dat2  Data frame 2"
#' @keywords findiff
#' @export
#' @examples findiff


findiff<-function(dat1,dat2){
  dum1a<-""
  nm1<-"dat1"
  dum2a<-""
  nm2<-"dat2"
  for(i in 1:length(names(dat1))){
    nm1<-paste(nm1,names(dat1)[i],sep="/")
    dum1a<-paste(dum1a,dat1[,names(dat1)[i]],sep="/")
    nm2<-paste(nm2,names(dat2)[i],sep="/")
    dum2a<-paste(dum2a,dat2[,names(dat2)[i]],sep="/")
  }
  a<-setdiff(dum1a,dum2a)
  b<-setdiff(dum2a,dum1a)
  out<-data.frame(nm1=unique(a));names(out)<-nm1
  out1<-data.frame(nm2=unique(b));names(out1)<-nm2
  row1<-data.frame(N1=length(dum1a),N2=length(dum2a))
  out3<-lhcbind(out,out1)
  out3<-lhcbind(out3,row1)
  out3 }


#' lhjoin funtion
#'Join two datasets and print report of joining procedure
#' @param dat1 by1 Data frame 1 and variables to be matched. If NULL, match="all"
#' @param dat2 by2 Data frame 2 and variables to be matched. If by1=NULL then by2=NULL then match="all"
#' @param type could be "full", "left","right" or "inner"
#' @keywords lhjoin
#' @export

lh.join<-function(dat1,by1=NULL,dat2,by2=NULL,type="full"){
  invar<-intersect(names(dat1),names(dat2))
  if(is.null(by1)){
    by1=invar}else{
      by1=by1}
  if(is.null(by2)){
    by2=invar
  }else{
    by2=by2
    #names(dat2)[names(dat2)%in%invar]<-paste0("df2_",names(dat2)[names(dat2)%in%invar])
  }

  if(length(by1)>1){
    dat1[,"dum"]<-dat1[,by1[1]]
    for(i in 2:length(by1)){
      dat1[,"dum"]<-paste(dat1[,"dum"],dat1[,by1[i]],sep="-")
    }}else{dat1[,"dum"]<-dat1[,by1[1]]}

  by2[!by2%in%by1]<-paste0("df2_",by2[!by2%in%by1])

  if(length(by2)>1){
    dat2[,"dum"]<-dat2[,by2[1]]
    for(i in 2:length(by2)){
      dat2[,"dum"]<-paste(dat2[,"dum"],dat2[,by2[i]],sep="-")
    }}else{dat2[,"dum"]<-dat2[,by2[1]]}

  if(type=="left"){
    dat2<-nodup(dat2,by2,"all")}else{dat2<-dat2}
  dat<-plyr::join(dat1,dat2,by="dum",type=type)

  report<-data.frame(nrow_data1=nrow(dat1),
                     nrow_data2=nrow(dat2),
                     nrow_joint=nrow(dat))
  for(c in 1:length(by1)){
    x<-data.frame(z=setdiff(dat1[,by1[c]],dat2[,by2[c]]))
    names(x)<-paste0(by1[c],"_not_in_data2")
    y<-data.frame(z=setdiff(dat2[,by2[c]],dat1[,by1[c]]))
    names(y)<-paste0(by1[c],"_not_in_data1")
    zz<-lhcbind(x,y)
    report<-lhcbind(report,zz)
  }
  print(head(report))
  dat}



#' lhorder funtion
#'
#' Make simple table. Use data frame created by addvar2
#' @param dat Data frame
#' @param var Order by variables. ex: ":Trt,:Agegr"
#' @keywords lhorder
#' @export


lhorder<-function(dat,var){
  data<-dat
  x<-paste0("data[order(",gsub(":","data$",var),"),]")
  b<- function(x) {}
  body(b) <- parse(text = x)
  data<-b()
}



#' lhtab funtion
#'
#' Make simple table. Use data frame created by addvar2
#' @param data Datframe
#' @param vh Vertical and horizontal headers. ex: "Trt+Agegr~Param"
#' @param value Values.
#' @param ord Order variables. ex: ":Trt,:Agegr"
#' @param save.name Save table as word document. Enter the file name: ex "test.docx"
#' @param output output="csv" for csv output, else output will be in FlexTable format
#' @keywords lhtab
#' @export


lhtab<-function (data, vh, value, ord = NULL, save.name = NULL, output = "csv")
{
  b <- function(x) {
  }
  body(b) <- parse(text = vh)

  v <- gsub("+", ":", sub("~.*", "", vh), fixed = T)
  v <- unlist(strsplit(v, ":"))
  h <- gsub("+", ":", sub(".*~", "", vh), fixed = T)
  list(gsub(":", ",", h))
  h <- unlist(strsplit(h, ":"))
  data$dum<-""
  for(i in h){
    if(i==h[1]){
      data$dum<-data[,i]}else{data$dum<-paste(data$dum,data[,i],sep="_")}
  }


  hd<-nodup(data,c("dum",v,h),"var")
  w<-NULL
  for(uu in value){
    data[,"stats"]<-uu
    w1 <- reshape(data[,c(v,"dum",uu,"stats")],
                  timevar ="dum",
                  idvar =c(v,"stats"),
                  direction = "wide")
    for(u in names(data[,c(v,"dum",uu,"stats")])){
      rm<-paste0(u,".")
      names(w1)<-gsub(rm,"",names(w1),fixed = T)
    }
    w<-rbind(w,w1)}
  hw<-NULL

  for(d in h){
    hd[,"stats"]<-"stats"
    hw1 <- reshape(hd[,c("dum",v,d,"stats")],
                   timevar ="dum",
                   idvar =c(v,"stats"),
                   direction = "wide")

    for(u in names(hd[,c("dum",v,d,"stats")])){
      rm<-paste0(u,".")
      names(hw1)<-gsub(rm,"",names(hw1),fixed = T)
    }
    hw1<-nodup(hw1,names(hw1)[!names(hw1)%in%c(v,"stats")],"all")
    hw<-rbind(hw,hw1)
  }
  hw<-hw[,unique(names(hw))]
  for(vv in v){
    hw[,vv]<-vv
  }

  setdiff(names(w),names(hw))

  hw1<-rbind(hw,w)
  head(hw1,10)


  if (!is.null(ord)) {
    y <- paste0(ord, ",:stats")
  }else {
    y <- ":stats"
  }
  stor<-c("stats",value)
  hw1[,"stats"]<-factor(hw1[,"stats"],level=stor)
  head(hw1)

  hw1 <- lhorder(hw1,y)

  hw1 <- chclass(hw1, names(hw1), "char")
  tab <- ReporteRs::FlexTable(hw1, header.columns = FALSE)

  for (y in c(v,"stats")) {
    tab = ReporteRs::spanFlexTableRows(tab, j = y, runs = as.character(hw1[,
                                                                           y]))
  }
  t4 <- hw1
  colnames(t4) <- NULL
  rownames(t4) <- NULL
  for (z in 1:length(h)) {
    tab = ReporteRs::spanFlexTableColumns(tab, i = z, runs = paste(t4[z,
                                                                      ]))
  }
  tab[1:length(h), ] = ReporteRs::textProperties(font.weight = "bold")
  tab[, names(hw1)] = ReporteRs::parCenter()
  if (!is.null(save.name)) {
    doc <- ReporteRs::docx()
    doc <- ReporteRs::addFlexTable(doc, tab)
    ReporteRs::writeDoc(doc, save.name)
    ReporteRs::writeDoc(doc, save.name)
  }
  if (output != "csv") {
    res <- tab
  }
  else {
    res <- hw1
  }
  res
}


#' install.pack
#'
#' To install require packages. Use ipak function to install desired packages.
#' @param packages pre-define packages list.
#' @keywords install.pack
#' @export

install.pack<-function(...){
  packages <- c("SASxport", "reshape", "Hmisc", "tidyr","ReporteRs","plyr","downloader","officer")
  ipak(packages)}


#' lhrbind
#'
#' r bind 2 data frames regardless number of columns.
#' @param dat1 data frames 1.
#' @param dat2 data frames 2.
#'
#' @keywords lhrbind
#' @export


lhrbind<-function (dat1, dat2, na.replace = NA, all.character = T)
{
  dat1[, setdiff(names(dat2), names(dat1))] <- na.replace
  dat2[, setdiff(names(dat1), names(dat2))] <- na.replace
  if (all.character) {
    dat <- rbind(chclass(dat1, names(dat1), "char"), chclass(dat2,
                                                             names(dat2), "char"))
    print("Warning: all vectors in new dataset are character")
    dat
  }
  else (dat <- rbind(dat1, dat2))
}

#' lhcbind
#'
#' C bind 2 data frames regardless number of row length.
#' @param dat1 data frames 1.
#' @param dat2 data frames 2.
#' @keywords lhcbind
#' @export


lhcbind<-function(dat1,dat2){
  dat1=as.data.frame(dat1)
  dat2=as.data.frame(dat2)
  r1<-nrow(dat1)
  r2<-nrow(dat2)
  if(r1>r2){
    r3=as.data.frame(matrix(ncol=ncol(dat2),nrow=r1-r2,data=""))
    names(r3)<-names(dat2)
    r3=rbind(dat2,r3)
    dat=cbind(dat1,r3)
  }
  if(r1<r2){
    r3=as.data.frame(matrix(ncol=ncol(dat1),nrow=r2-r1,data=""))
    names(r3)<-names(dat1)
    r3=rbind(dat1,r3)
    dat=cbind(r3,dat2)
  }
  if(r1==r2){dat=cbind(dat1,dat2)}
  dat
}

#' lhloess
#'
#' Compute the LOESS data for ploting.
#' @param data data.
#' @param x Independent variable
#' @param y Dependent variable
#' @param by Sort by. Only one sorting variable is accepted. If more than 1 variables, create a unique sorting using paste: var1,var2,etc
#' @param span LOESS stiffness
#' @keywords lhloess
#' @export


lhloess<-function(data,x,y,by,span=1){
  library(plyr)
  data$x=data[,x]
  data$y=data[,y]
  data$by=data[,by]
  head(data)
  dat=NULL
  for(i in unique(data$by)){
    tmp<-data[data$by==i,c(x,"x","y")]
    head(tmp)
    tmp1<-with(tmp,unlist(predict(loess(y~x,tmp,span=span),x)))
    tmp$loess<-tmp1
    dat<-rbind(dat,tmp)
  }
  #data$x<-data$y<-data$by<-NULL
  data<-join(data,dat)
}


#########
#' TAD from ADDL
#'
#' This function allows you to derive time after dose from ADDL.
#' @param data data frame
#' @param id ID vector
#' @param ii dose interval vector
#' @param addl additional dose vector
#' @param rtime relative time after first dose vector
#' @param evid EVID vector
#' @param dose amount adminstered (ex: AMT) vector
#' @param dose.expand If "yes", all dosing rows in ADDL will be outputed
#' @keywords tad
#' @export


tad_addl<-function (data, id = "USUBJID", ii = "II", addl = "ADDL",
                    rtime = "RTIME", evid = "EVID", dose.expand = "yes",
                    cdate = "DATE", ctime = "CTIME")
{
  data <- chclass(data, c(rtime, evid, addl, ii), "num")
  if (!is.null(cdate) & !is.null(ctime)) {
    data[, "datetime"] <- paste(data[, cdate], data[,
                                                    ctime])
  }else {
    data
  }
  data[, addl][is.na(data[, addl])] <- 0
  data[, ii][is.na(data[, ii])] <- 0
  data[, "TAD"] <- data[, "tad"] <- NULL
  nam <- names(data)
  data <- data[order(data[, id], data[, rtime]), ]
  dose <- data[data[, evid] == 1, ]
  dose[, "TAD"] <- 0
  datp <- data[data[, evid] != 1, ]
  dat0 <- data[data[, evid] == 1, ]
  datr <- NULL
  for (i in 1:nrow(dat0)) {
    dat1 <- dat0[i, ]
    if (dat1[, addl] == 0) {
      dat2 <- dat1
    }else {
      dat2 <- as.data.frame(matrix(ncol = ncol(dat1), nrow = dat1[,
                                                                  addl] + 1))
      names(dat2) <- names(dat1)
      dat2[, names(dat2)] <- dat1
      dat2$dum <- seq(0, nrow(dat2) - 1, 1)
      dat2[, rtime] <- dat2[, rtime] + (dat2[, ii] * dat2$dum)
      dat2$dum <- NULL
    }
    if (!is.null(dat2[, "datetime"])) {
      f0 <- dat2$RTIME[1]
      dat2[, "datetime"] <- addtime(dat2[, "datetime"],
                                    dat2[, rtime] - f0)
    } else {
      dat2
    }
    setdiff(names(datr), names(dat2))
    dat2$exseq <- i
    datr <- rbind(datr, dat2)
  }
  datr <- nodup(datr, names(datr), "all")
  datr[, addl] <- datr[, ii] <- 0
  setdiff(names(datr), names(datp))
  if (nrow(datp) != 0) {
    datp$exseq <- (-99)
    datp$loc1 <- NA
    datp$lhdose <- "no"
  } else {
    datp <- NULL
  }
  datr$loc1 <- datr[, rtime]
  datr$lhdose <- "yes"
  datp1 <- rbind(datp, datr)
  datp1 <- datp1[order(datp1[, id], datp1[, rtime]), ]
  head(datp1)
  datp1 <- locf2(datp1, id, "loc1")
  datp1$TAD <- datp1[, rtime] - datp1$loc1
  datp1$TAD[datp1$TAD < 0] <- 0
  range(datp1$TAD)
  datp1
  if (dose.expand != "yes") {
    d1 <- datp1[datp1$lhdose == "no", ]
    d1$loc1 <- d1$lhdose<-d1$exseq <- NULL
    data <- rbind(d1, dose)
    data <- data[order(data[, id], data[, rtime]), ]
  } else {
    data <- datp1[, !names(datp1) %in% c("loc1", "lhdose","exseq")]
  }
  data
}

###########
#' BLQ M6 Method
#'
#' This function allows you to create data with BLQ using M6 method.
#' @param data data frame
#' @param id ID vector
#' @param evid EVID vector
#' @keywords m6
#' @export

m6<-function(data,id,evid,mdv,blq.flag,time,dv,lloq){
  dat<-data
  #id="id";time="RTIME";mdv="mdv";evid="evid";blq.flag="blqf";dv="dv";lloq=0.01
  dat$cum<-cumsum(dat[,evid])
  dat$cum1<-cumsum(dat[,blq.flag])

  good<-addvar(dat[dat[,evid]==0&dat[,mdv]==0,],c(id,"cum"),time,"max(x)","no","good")
  good1<-addvar(dat[dat[,time]>0&dat[,blq.flag]==1,],c(id,"cum1"),time,"min(x)","no","good1")
  good1[,time]<-good1$good1
  good

  m4<-plyr::join(dat,good)
  m4<-plyr::join(m4,good1)
  good2<-addvar(m4[m4$good<=m4$good1,],c(id,"cum"),"good1","min(x)","no","good2")
  good2[,time]<-good2$good2

  good3<-addvar(m4[m4$good>=m4$good1,],c(id,"cum"),"good1","max(x)","no","good3")
  good3[,time]<-good3$good3

  m4<-plyr::join(m4,good2)
  m4<-plyr::join(m4,good3)
  m4$dvm6<-m4[,dv]
  m4$mdvm6<-m4[,mdv]

m4$dvm6[m4[,time]==m4$good2|m4[,time]==m4$good3]<-lloq/2
m4$mdvm6[m4[,time]==m4$good2|m4[,time]==m4$good3]<-0
m4$cum<-m4$cum1<- m4$good<-m4$good1<-m4$good2<-m4$good3<-NULL
  m4
}


#-------------------------
#' Reflag variables
#'
#' This function allows you to change variable name ex: "M" to "Male".
#' @param dat data frame
#' @param var Vector to be changed
#' @param orignal.flag Original names ex:"M","F"
#' @param new.flag New names ex:c"Male","Female"
#' @param newvar Create new vector
#' @keywords reflag
#' @export

reflag<-function (dat, var, orignal.flag, new.flag=NULL,newvar=NULL,to.factor=T,missing=c("",".","NA",NA))
{
  if(is.null(new.flag)){
    new.flag=orignal.flag
  }else{new.flag}
  forgot<-setdiff(dat[,var],orignal.flag)
  forgot<-forgot[!forgot%in%missing]
  print(paste("forgot:",forgot))
  stopifnot(length(forgot)==0)
  dat[,var]<-as.character(dat[,var])
  dat[dat[,var]%in%missing,var]<-"missing or unknown"
  orignal.flag<-as.character(orignal.flag)
  new.flag<-as.character(new.flag)
  dat[,var]<-as.character(dat[,var])
  if(!is.null(newvar)){
    dat[,newvar]<-factor(dat[,var],levels=c(orignal.flag,"missing or unknown"),
                         labels=c(new.flag,"missing or unknown"))
    if(to.factor==F){
      dat[,newvar]<-as.character(dat[,newvar])
    }}else{dat[,var]<-factor(dat[,var],levels=c(orignal.flag,"missing or unknown"),
                             labels=c(new.flag,"missing or unknown"))
    if(to.factor==F){
      dat[,var]<-as.character(dat[,var])
    }}
  dat
}


#' Derived 1 variable and 1 function
#'
#' This function allows you to add derived variable (ex: add mean value by ID).
#' @param dat data frame
#' @param sort sort derived variable by ex:"ID","SEX"
#' @param var variable to be derived
#' @param fun deriving function ex:"mean x"
#' @param add.to.data if "yes" result will be appended to dat
#' @param name column name of derived variable
#' @keywords addvar
#' @export

addvar<-function(dat,sort,var,fun,add.to.data="yes",name=NULL){
  d<-dat
  a<-fun
  if(is.null(name)){name=paste0(gsub("(x)",var,fun))}
  b<-function(x){}
  body(b)<-parse(text=a)

  if(length(sort)>1){dd<-(aggregate(d[,var],d[,sort],b))}else{dd<-(aggregate(d[,var],list(d[,sort]),b))}
  names(dd)<-c(sort,name)
  if(add.to.data=="yes"){out<-plyr::join(dat,dd,type="left")}else{out<-dd}}


#' Derived more variables and functions
#'
#' This function allows you to add derived variable (ex: add mean value by ID).
#' @param dat data frame
#' @param sort sort derived variable by ex:"ID","SEX"
#' @param var variable to be derived
#' @param fun deriving function ex:c"mean x =mean","length x is.na x")
#'
#' @keywords addvar
#' @export


addvar2<-function (dat, sort=c("SEX"), var="Cmax", fun="mean(x)=Mean", rounding = "sigfig(x,3)")
{
  tmp1 <- NULL
  stn <- NULL
  for (z in 1:length(fun)) {
    fy = gsub("=", "", sub(".*=", "=", fun[z]))
    fx <- gsub(sub(".*=", "=", fun[z]), "", fun[z])
    tmp <- NULL
    stn <- c(stn, fy)
    for (v in var) {
      t <- addvar(dat = dat, sort = sort, var = v, fun = fx,
                  add.to.data = "no", name = fy)
      t$var <- v
      tmp <- rbind(tmp, t)
      tmp[, fy] <- as.numeric(as.character(tmp[, fy]))
      rounding1 <- "round(x,10)"
      if (!fy %in% c("N", "n")) {
        a <- gsub("x", "tmp[,fy]", rounding1)
        b <- function(x) {
        }
        body(b) <- parse(text = a)
        tmp[, fy] <- b()
      }
      else {
        tmp
      }
    }
    if (z == 1) {
      tmp1 <- tmp
    }
    else {
      tmp1 <- join(tmp1, tmp)
    }
  }
  a <- rounding
  b <- function(x) {
  }
  body(b) <- parse(text = a)
  for (z in stn[!stn %in% c("N", "n")]) {
    for(x in 1:nrow(tmp1)){
      tmp1[,z] <- b(as.numeric(tmp1[, z]))
    }
  }
  tmp1
}


#' Add time in hour to calendar date/time
#'
#' This function allows you to add derived variable (ex: add mean value by ID).
#' @param datetime date/time vector to be computed
#' @param timehour Time to be added in hour
#' @param format date and time format
#' @param tz Time zone (default="GMT")
#' @param add.to.data if "yes" result will be appended to dat
#' @param name column name of derived variable
#' @keywords addtime
#' @export


addtime<-function(datetime,timehour,format="%Y-%m-%d %H:%M",tz="GMT"){
  output<-substring(strptime(datetime,format=format,tz=tz)+timehour*60*60,1,16)
  output}


###TAD calculation using elapsed RTIME#########
#' Derive TAD from RTIME
#'
#' This function allows you to derive Time after dose from Time after first dose.
#' @param data data frame
#' @param id subject id
#' @param time time after first dose
#' @param evid evid
#' @keywords rt2tad
#' @export

rt2tad<-function(data,id="USUBJID",time="RTIME",evid="EVID"){
  data$cumsum<-unlist(tapply(data[,evid],list(data[,id]),cumsum))
  nrow(data)
  data$time<-data[,time]
  d<-data[data[,evid]==1,c(id,time,"cumsum")]
  names(d)<-c(id,"time1","cumsum")
  data$sort<-seq(1,nrow(data),1)
  d<-nodup(d,c(id,"cumsum"),"all")
  data1<-plyr::join(data,d,type="left")
  data1<-chclass(data1,c("time","time1"),"num")
  data1$tad<-with(data1,time-time1)
  data1$ndose<-data1$cumsum
  data1<-data1[order(data1$sort),];data1$sort<-data1$time1<-data1$time<-data1$cumsum<-NULL
  data1
}
####create NMEM UNIQUE SUBJECT####
#' NMID
#'
#' This function allows you to create NMID.
#' @param data data frame
#' @param id subject id
#' @param varname column name
#' @keywords nmid
#' @export

nmid<-function(data,id="USUBJID",varname="NMID"){
  id=id;varname=varname
  data<-data
  data$ord<-seq(1,nrow(data),1)
  idat<-data.frame(id=unique(data[,id]),varname=seq(1,length(unique(data[,id])),1))
  names(idat)<-c(id,varname)
  data<-merge(data,idat)
  data<-data[order(data[,varname],data$ord),]
  data$ord<-NULL
  data
}


#' Compute delta using calendar date and time
#'
#' This function allows you to compute the delta (time1-time2).
#' @param tm1 data frame
#' @param tm2 subject id
#' @param form1 date/time format 1
#' @param form2 date/time format 2
#' @keywords diftm
#' @export

diftm<-function(tm1,tm2,unit="hour",form1="%Y-%m-%d %H:%M",form2="%Y-%m-%d %H:%M",tz="GMT"){
dat<- as.numeric(difftime(strptime(tm1,format=form1,tz=tz),strptime(tm2,format=form2,tz=tz), units=unit))
 dat}


#' Reformat calendar date/time
#'
#' This function allows you to change the date/time format.
#' @param dttm original date/time
#' @param tm2 subject id
#' @param form1 date/time format 1 to be changed
#' @param form2 new date/time format
#' @keywords format_time
#' @export


format_time<-function(dttm,form1,form2="%Y-%m-%d %H:%M",tz="GMT"){
  strftime(strptime(dttm,format=form1,tz=tz),format=form2,tz=tz)
}


#' Change variable class
#'
#' This function allows you to change variable class ("num" or "char").
#' @param data data
#' @param var variable (ex:c("DV","MDV"))
#' @param class class ("char" or "num")
#' @keywords chclass
#' @export

chclass<-function(data,var,class="char"){
   for(i in var){
    if (class=="num"){
      data[,i]<-as.numeric(as.character(data[,i]))}
    else {data[,i]<-as.character(data[,i])}
  }
  data
}

#' one
#'
#' one.
#' @param data data
#' @param var variable
#' @keywords one
#' @export

one<-function(data,var){
  for(i in var){
    print(i)
    print(data[!duplicated(data[,i]),i])
  }
}


#' No duplicate
#'
#' This function allows you to remove duplicates.
#' @param data data
#' @param var variable (ex:c("DV","MDV"))
#' @param all if all="all", all columns in data will be kept (ex:all=c("ID","DV"))
#' @keywords nodup
#' @export

nodup<-function(data,var,all,item){
  if(all=="all"){d1<-data[!duplicated(data[,var]),names(data)]}else{
    if(all=="var"){d1<-data[!duplicated(data[,var]),var]}else{
      d1<-data[!duplicated(data[,var]),c(var,item)]}}
  d1
}


#' Check duplicates
#'
#' This function allows you to check duplicates.
#' @param data data
#' @param var variable (ex:c("DV","MDV"))
#' @param remove if remove="yes", duplicates will be removed)
#' @keywords duprow
#' @export

duprow<-function(data,var=NULL,remove=NULL){
  flag="flag"
  data[,flag]<-""
  if(is.null(var)){
    var=names(data)}
  for(i in 1:length(var)){
    data[,flag]<-paste(data[,flag],data[,var[i]],sep="")
  }
  if(is.null(remove)){
    data[duplicated(data[,"flag"]),]}
  else{data1<-data[!duplicated(data[,"flag"]),]
       data1[,"flag"]<-NULL
       data1}
}

#' Derive TAD and RTIME
#'
#' Derive TAD and RTIME from calendar date and time or dttm
#' @param data data
#' @param id subject id
#' @param date date variable
#' @param time time variable
#' @param EVID evid variable
#' @keywords tadRT
#' @export

tadRT<-function (data, id="ID",dttm=NULL ,cdate=NULL, ctime=NULL, evid="EVID", tz ="GMT",format="%Y-%m-%d %H:%M")
{
  locf <- function(x) {
    good <- !is.na(x)
    positions <- seq(length(x))
    good.positions <- good * positions
    last.good.position <- cummax(good.positions)
    last.good.position[last.good.position == 0] <- NA
    x[last.good.position]
  }
  data$TAD <- data$RTIME <- NULL

  if(!is.null(dttm)){
    data$DTTM <- as.character(data[,dttm])
    data[,dttm]<-NULL
    data <- data[order(data[, id],data$DTTM),]
    data$tadtm <- NA}else{
    data <- chclass(data, c(cdate, ctime), "char")
    data$DTTM <- as.character(paste(data[, cdate], data[, ctime],
                                       sep = " "))
 data$tadtm <- NA
 data <- data[order(data[, id],data$DTTM), ]
 }

  head(data)
  dtm <- data[data[, evid] > 0, ]
  rtime <- dtm[!duplicated(dtm[, id]), c(id, "DTTM")]
  names(rtime)[2] <- "FDDTM"
  nodose <- data[data[, evid] == 0, ]
  dose <- data[data[, evid] > 0, ]
  dose$tadtm <- as.character(dose$DTTM)
  data <- rbind(dose, nodose)
  data$tadtm <- as.character(data$tadtm)
  head(data)

  data$DTTM <- strftime(strptime(data$DTTM, format = format,
                                 tz = tz), format = format, tz = tz)
  data <- data[order(data[, id], data$DTTM), ]
  data$WT1 <- unlist(tapply(data$tadtm, data[, id], locf))
  data$tadtm <- rev(locf(rev(data$WT1)))
  data <- data[order(data[, id],data$DTTM), ]
  head(data)
  data$DTTM <- strftime(strptime(data$DTTM, format = format,
                                 tz = tz), format = format, tz = tz)
  data$tadtm <- strftime(strptime(data$tadtm, format = format,
                                  tz = tz), format = format, tz = tz)
  data$TAD <- as.numeric(difftime(strptime(data$tadtm, format = format,
                                           tz = tz), strptime(data$DTTM, format = format,
                                                              tz = tz), units = "hour")) * (-1)
  data <- merge(data, rtime, all.x = T)
  data$RTIME <- as.numeric(difftime(strptime(data$DTTM, format = format,
                                             tz = tz), strptime(data$FDDTM, format = format,
                                                                tz = tz), units = "hour"))
  data$WT1 <- NULL
  data$tadtm <- NULL
  data$FDDTM <- NULL
  data <- data[order(data[, id], data$DTTM), ]
  data$RTIME <- round(data$RTIME, 4)
  data$TAD <- round(data$TAD, 4)
  data
}


#' LOCF and LOCB
#'
#' LOCF LOCB function
#' @param data data
#' @param var variable to locf
#' @param by sort variable
#' @param locb carry backward
#' @keywords locb2
#' @export

locf2<-function (data=scd, by = "ID", var = "dostm", locb = T)
{

  locf <- function(x) {
    good <- !is.na(x)
    positions <- seq(length(x))
    good.positions <- good * positions
    last.good.position <- cummax(good.positions)
    last.good.position[last.good.position == 0] <- NA
    x[last.good.position]
  }
  dat<-NULL
  for(i in unique(data[,by])){
    dat1<-data[data[,by]==i,]
    dat1$dumy <- seq(1, nrow(dat1))
    dat1[,var]<-unlist(locf(dat1[, var]))

    if (locb) {
      dat1 <- dat1[order(-(dat1$dumy)), ]
      dat1[, var] <- locf(dat1[, var])
      dat1 <- dat1[order(dat1$dumy), ]
    }
    dat1$dumy <- NULL
    dat<-rbind(dat,dat1)
  }
  dat
}


# 1 cpt
#' One compartment micro constants and HL
#'
#' This function allows you to derive TAD and RTIME from calendar date/time.
#' @param data data
#' @keywords hl1cpt
#' @export

hl1cpt<-function(cl,v){

  k<-cl/v
  HL<-log(2)/k
  datf<-data.frame(k=k,HL=HL)
  datf
  }


#Two-compartment
#' Two compartment micro constants and HL
#'
#' This function allows you to derive micro constants and HL.
#' @param data data
#' @keywords hl2cpt
#' @export

hl2cpt<-function(cl,cl2,v,v2){
  k<-cl/v
  k12<-cl2/v
  k21<-cl2/v2
beta1<-(1/2)*(k12+k21+k-(sqrt((k12+k21+k)^2-(4*k21*k))))
alfa<-k21*k/beta1
alfaHL<-log(2)/alfa    # to be verify with excel
betaHL<-log(2)/beta1    # to be verified with excel
datf<-data.frame(k=k,k12=k12,k21=k21,alfa=alfa,beta=beta1,HLa=alfaHL,HLb=betaHL)
datf
}

# Three CPT
#' Three compartment micro constants and HL
#'
#' This function allows you to derive micro constants and HL.
#' @param data data
#' @keywords hl3cpt
#' @export

hl3cpt<-function(Cl,Cl2,Cl3,V,V2,V3){

  k<-Cl/V
  k12<-Cl2/V
  k21<-V*k12/V2
  k13<-Cl3/V
  k31<-V*k13/V3
  a0<-k*k21*k31
  a1<-(k*k31) + (k21*k31) + (k21*k13) + (k*k21) + (k31*k12)
  a2<-k + k12 + k13 + k21 + k31
  p<-a1 - (a2^2)/3
  q<-2*(a2^3)/27 - a1*a2/3 + a0
  r1<-sqrt((-1)*p^3/27)
  r2<-2*(r1^(1/3))
  phi<-acos(-1*q/(2*r1))/3
  gama<-(-1)*((cos(phi)*r2)-(a2/3))
  alpha<-(-1)*(cos(phi+(2*pi/3))*r2-a2/3)
  beta<-(-1)*(cos(phi+(4*pi/3))*r2-a2/3)
  alfaHL<-log(2)/alpha
  betaHL<-log(2)/beta
  gamaHL<-log(2)/gama
  A=(1/V)*((k21-alpha)/(alpha-beta))*((k31-alpha)/(alpha-gama))
  B=(1/V)*((k21-beta)/(beta-alpha))*((k31-beta)/(beta-gama))
  C=(1/V)*((k21-gama)/(gama-beta))*((k31-gama)/(gama-alpha))
  datf<-data.frame(HLa=alfaHL,HLb=betaHL,HLg=gamaHL,alpha=alpha,beta=beta,gama=gama,A=A,B=B,C=C)
  datf
}


#Round old method
#' Rounding as per Excel Internal use
#'
#' This function allows you to round value as per Excel method.
#' @keywords cround
#' @export

cround1= function(x,n,asnum=T){
  vorz = sign(x)
  z = abs(x)*10^n
  z = z + 0.5
  z = trunc(z)
  z = z/10^n
ifelse(is.na(x),output<-NA,
  output<-sprintf(paste("%.",n,"f",sep=""),z*vorz))
if(asnum){output<-as.numeric(as.character(output))}else{
output}
output
}

#' Round up
#'
#' This function allows you to round value as in Excel.
#' @param z Vector or single value to be rounded
#' @param y number of significant figure
#' @keywords rounding
#' @export

cround<-function (z, y)
{
  if(length(z)>1){
    output<-NULL
    for(i in 1:length(z)){
      output1<-cround1(as.numeric(z[i]),y)
      output<-rbind(output,output1)}
    output
  }else{output<-cround1(as.numeric(z),y)
  output
  }}


#sigfig Internal Use
#' Significant figure
#'
#' This function allows you to round value in significant figure.
#' @keywords sigfig
#' @export

sigfig1<-function (x, y)
{
  sround = function(x, n) {
    vorz = sign(x)
    z = abs(x) * 10^n
    z = z + 0.5
    z = trunc(z)
    z = z/10^n
    ifelse(is.na(x), sro <- NA, sro <- z * vorz)
    sro
  }
  nround <- ifelse(x == 0, y - 1, y - 1 - floor(log10(abs(x))))
  if (!is.na(x) & ceiling(log10(abs(x))) >= 3) {
    output <- as.character(cround(x, 0))
  }else {
    if (!is.na(x) & ceiling(log10(abs(x)))<3) {
      output <- sprintf(paste("%.", nround, "f", sep = ""),
                        sround(x, nround))
    }else{
      output <- NA
    }
  }
  output
}

#Sigfig
#' Significant figure
#'
#' This function allows you to round value in significant figure.
#' @param z Vector or single value to be rounded
#' @param y number of significant figure
#' @keywords sigfig
#' @export

sigfig<-function (z, y)
{
  if(length(z)>1){
    output<-NULL
    for(i in 1:length(z)){
      output1<-sigfig1(as.numeric(z[i]),y)
      output<-rbind(output,output1)}
    output
  }else{output<-sigfig1(as.numeric(z),y)
  output
  }}


#' Filter unique duplicated row
#'
#' This function allows you to filter duplicated rows but only show unique row
#' @param data data
#' @param data data
#' @param all display all columns (all="all")
#' @param select display selected variables only
#' @keywords dup1
#' @export

dup1<-function(data,var,all,select){
  d1<-data[duplicated(data[,var]),]
  if(all=="all"){d1<-d1}else{
    if(all=="var"){d1<-d1[,var]}else{
      d1<-d1[,c(var,select)]}}
  d1
}


#' Filter all duplicated rows
#'
#' This function allows you to filter duplicated rows but only show unique row
#' @param data data
#' @param data data
#' @param all display all columns (all="all")
#' @param select display selected variables only
#' @keywords dup2
#' @export

dup2<-function(data,var,all,select){
  d1<-data
  d1$dum<-""
  for(i in var){
    d1$dum<-paste(d1$dum,d1[,i],sep="-")
  }
  dup<-d1[duplicated(d1$dum),"dum"]
  d1<-d1[d1$dum%in%dup,]
  if(all=="all"){d1<-d1[,names(data)]}else{
    if(all=="var"){d1<-d1[,var]}else{
      d1<-d1[,c(var,select)]}}
  d1
}

#TABLE FUNCTIONS###############
#' bround Table function
#' @param data data
#' @keywords bround
#' @export

bround<-function(data,var,rtype="sigfig",dec=3){
  data<-chclass(data,var,"num")
  for(i in var){
    data[is.na(data[,i]),i]<-9999999999999
    if(rtype=="sigfig"){data[,i]<-sigfig(data[,i],dec)}else{data[,i]<-cround(data[,i],dec)}
    data[data[,i]=="9999999999999",i]<-"NA"
  }
  data
}

#' geom Table function
#'
#' @param x data
#' @keywords geom
#' @export

geom <- function(x) {
  exp(mean(log(x[x > 0]), na.rm=TRUE))
}

#' geocv Table function
#' @param x data
#' @keywords geocv
#' @export

geocv <- function(x) {
  100*sqrt(exp(var(log(x[x > 0]), na.rm=TRUE)) - 1)
}

#' cv Table function
#' @param x data
#' @keywords cv
#' @export
cv <- function(x) {
  abs(sd(x,na.rm=TRUE)/mean(x,na.rm=TRUE)*100)
}


#' se Table function
#' internal use.
#' @param x data
#' @keywords se
#' @export

se<-function(x){sd(x,na.rm=TRUE)/(length(x))^0.5}

#' cilow Table function
#'
#' internal use
#' @param x data
#' @keywords generic
#' @export

cilow<-function(x){mean(x,na.rm=TRUE)-((sd(x,na.rm=TRUE)/(length(x))^0.5)*qt(0.975,df=length(x)-1))}    #1.96)}

#' ciup Table function
#' internal use.
#' @param x data
#' @keywords ciup
#' @export

ciup<-function(x){mean(x,na.rm=TRUE)+((sd(x,na.rm=TRUE)/(length(x))^0.5)*qt(0.975,df=length(x)-1))}

#' nmiss Table function
#' internal use.
#' @param x data
#' @keywords nmiss
#' @export

nmiss<-function(x){length(x[is.na(x)])}


################################################
#' roundbatch
#'
#' internal use
#' @keywords roundbatch
#' @export

roundbatch<-function(data,variable,toround,nb){
  head(data)
  data<-sum
  l<-stats::reshape(data,
             varying = variable,
             v.names = "value",
             timevar = "toround",
             times = variable,
             direction = "long")
  l<-l[!is.na(l$value),]
  if(toround=="sigfig"){
    l$value<-sigfig(l$value,nb)}else{l$value<-cround(l$value,nb)}
  l$id<-NULL
  keep<-names(l)[!names(l)%in%c("toround","value")]
  w <- stats::reshape(l,
               timevar = "toround",
               idvar = keep,
               direction = "wide")
  names(w)<-gsub("value.","",names(w))
  w
}


################COUNTS CATEGORICAL###############

#' Funtion for Descriptove Stats of Categorical Covariate
#'
#'
#' Descriptove stats of categorical covariates
#' cat.tab(data,var,by,colby="var",rowby=by)
#' @param data datset or data frame (ex:data=PKdatat)
#' @param var List of continuous covariates (ex:c("SEX","RACE"))
#' @param by  Stratification variable (ex: by="study")
#' @keywords cat.tab
#' @export
#' @examples cat.tab(data=dat,var=c("SEX","RACE"),by=c("study"),colby="var",rowby=by)

lhcattab<-function (data, var, by)
  {
  rowby = by
  dat1 <- chclass(data[, c(var, by)], c(var, by), "char")

  tot <- stats::reshape(dat1, varying = var, v.names = "value",
                        timevar = "var", times = var, direction = "long")
  tot$id <- NULL
  tot1 <- addvar(tot, c(by, "var"), "var", "length(x)", "no",
                 "tot")
  tot2 <- addvar(tot, c(by, "var", "value"), "var", "length(x)",
                 "no", "subt")
  tot11 <- nodup(tot1, c(by), "all")
  names(tot11)[names(tot11) == "tot"] <- "N="
  tot12 <- addvar(tot, c("var", "value"), "var", "length(x)",
                  "no", "Overall")
  tot13 <- addvar(tot, c("var"), "var", "length(x)", "no",
                  "tot")
  tot12 <- plyr::join(tot12, tot13)
  tot12$Overall <- with(tot12, paste0(Overall, " (", sigfig(Overall/tot *
                                                              100, 3), "%)"))
  tot12$tot <- NULL
  tot11$"N=" <- paste0(tot11$"N=", " (", sigfig(tot11$"N="/max(tot13$tot) *
                                                  100, 3), "%)")
  tot4 <- plyr::join(tot2, tot1)
  tot4$summary <- with(tot4, paste0(subt, " (", sigfig(subt/tot *
                                                         100, 3), "%)"))
  tot3 <- tot4[, c(by, "var", "value", "summary")]

  tto<-addvar(tot4,c(rowby),"tot","max(x)","yes","all")
  tto[,c("var","value")]<-"all"
  tto$all<-paste0(tto$all," (100%)")

  tto0<-tto;tto0$tot<-tto0$subt<-tto0$summary<-NULL
  w0 <- stats::reshape(tto0, timevar =rowby, idvar = c("var",
                                                       "value"), direction = "wide")
  names(w0)<-gsub("all.","",names(w0))

  tto1<-tot4;tto1$tot<-tto1$subt<-NULL
  w <- stats::reshape(tto1, timevar =rowby, idvar = c("var",
                                                      "value"), direction = "wide")
  names(w)<-gsub("summary.","",names(w))

  w<-rbind(w,w0)

  w1<-addvar(tot4,c("var","value"),"subt","sum(x)","no","overall")
  w2<-addvar(tot4,c("var"),"subt","sum(x)","no","overall1")
  w1<-plyr::join(w1,w2)

  w1$overall<-paste0(w1$overall," (",sigfig(w1$overall/w1$overall1*100,3),"%)")
  w1a<-w1[1,]
  w1a$var<-w1a$value<-"all"
  w1a$overall<-paste0(w1a$overall1," (100%)")
  w1<-rbind(w1,w1a)

  w<-plyr::join(w,w1[,c("var",  "value","overall")])
  w<-w[order(w$var),]
  w
}


#' Individual table with descriptive statse
#'
#' Listing of individual data and descriptove stats
#' @param data datset or data frame (ex:data=PKdatat)
#' @param id unique identifier
#' @param by  Stratification variable (ex: by="study")
#' @param variables Specify sorting variable to be displayed vertically. (ex: colby=by or colby="var")
#' @param rtype rounding type. (sigfig by default)
#' @param dec round decimal or number of significant figures
#' @keywords ind.tab
#' @export
#' @examples ind.tab(data=dat,id="NMID",by=c("study"))

indiv.tab<-function(data,id,by,variables,rtype="sigfig",dec=3){
  id<-id#
  data<-data[,c(id,by,variables)]#[!duplicated(data$id),]
  strat1<-by#c("phase")# mandatory
  convar<-variables #mandatory
  d1<-data[,c(id,strat1,convar)]
  d1<-chclass(d1,convar,"num")
  head(d1)

  t1<-NULL
  for(i in unique(d1[,strat1])){
    d0<-d1[d1[,strat1]%in%i,]
    l<-stats::reshape(d0,
               varying = c(convar),
               v.names = "score",
               timevar = "subj",
               times = c(convar),
               #new.row.names = 1:1000,
               direction = "long")
    head(l)
    l$id<-NULL
    str(l)
    st<-plyr::ddply(l,c(by,"subj"),summarise,
              N=round(length(score),0),
              Nmiss=round(length(score[is.na(score)]),0),
              Means=sigfig(mean(score,na.rm=T),3),
              SD=sigfig(sd(score,na.rm=T),3),
              cv=sigfig(cv(score),3),
              Median=sigfig(median(score,na.rm=T),3),
              Minimum=sigfig(min(score,na.rm=T),3),
              Maximum=sigfig(max(score,na.rm=T),3),
              GeoMean=sigfig(Gmean(score),3),
              GeoCV=sigfig(Gcv(score),3))
    keep<-names(st[,3:length(names(st))])
    l1<-stats::reshape(st,
                varying = c(keep),
                v.names = "Stats",
                timevar = "Results",
                times = c(keep),
                #new.row.names = 1:1000,
                direction = "long")
    l1$id<-NULL

    w<-stats::reshape(l1,
               timevar = "subj",
               idvar = c(strat1, "Results"),
               direction = "wide")
    names(w)<-gsub("Stats.","",names(w))
    head(d0)
    x1<-setdiff(names(d0),names(w))
    x2<-setdiff(names(w),names(d0))
    w[,x1]<-""
    d0[,x2]<-""
    d0<-d0[,c(id,strat1,x2,convar)]
    #d0<-chclass(d0,convar,"num")
    if(!is.null(rtype)){
      d0<-bround(d0,convar,rtype=rtype,dec=dec)}
    t<-rbind(d0,w)
    t<-t[,c(id,strat1,x2,convar)]
    t1<-rbind(t1,t)
  }
  t1
}

#' Calculate AUC Using the Trapezoidal Method
#'
#' data
#' @param data.frame containing the data to use for the AUC calculation
#' @param time	chronologically ordered time variable present in data
#' @param id	variable in data defining subject level data
#' @param dv	dependent variable used to calculate AUC present in data
#' @keywords AUC
#' @export
#' @examples AUC(data, time = 'TIME', id = 'ID', dv = 'DV')

AUC<-function (data, time = "TIME", id = "ID", dv = "DV")
{
  if (any(is.na(data[[id]])))
    warning("id contains NA")
  if (any(is.na(data[[time]])))
    warning("time contains NA")
  if (any(is.na(data[[dv]])))
    warning("dv contains NA")
  data <- data[order(data[[id]], -data[[time]]), ]
  nrec <- length(data[[time]])
  data$diff <- c(data[[time]][-nrec] - data[[time]][-1], 0)
  data$meanDV <- c((data[[dv]][-1] + data[[dv]][-nrec])/2,
                   0)
  data$dAUC <- data$diff * data$meanDV
  data <- data[order(data[[id]], data[[time]]), ]
  data <- data[duplicated(data[[id]]), ]
  AUC <- aggregate.data.frame(data$dAUC, by = list(data[[id]]),
                              FUN = sum)
  names(AUC) <- c(id, "AUC")
  return(AUC)
}

#' Derive Common NCA parameters using single and multiple profiles
#'
#' nca.cal()
#' @param data datset or data frame (ex:data=PKdatat)
#' @param id unique subject identifier
#' @param n_lambda  number of points for estimating the Lambda
#' @param time Sampling time after dose (TAD)
#' @param dv Concentration
#' @param partialAUC Time interval for partial AUC. Ex: c(0,6,0,12,6,12) for AUC0-6, AUC0-12 and AUC6-12
#' @param partialConc Point estimated concentration (Ex:c(1,4) for concentration after 1 and 4 h)
#' @keywords nca.cal
#' @export
#'@examples test<-nca.cal(data=data,n_lambda = 3, id = "id", time = "TAD", dv = "dv",dose

nca.cal<-function (data, n_lambda = 3, id = "id", time = "TAD",
                   dv = "dv", partialAUC =NULL, partialConc =NULL)
{
  dat1<-data
  dat1$id<-dat1[,id]
  dat1$time<-dat1[,time]
  dat1$dv<-dat1[,dv]
  dat1$uid<-dat1[,id]

  dat1$tad<-dat1[,time]
  dat1$tad[dat1$tad < 0] <- 0
  dat2 <- dat1
  dat2 <- dat2[order(dat2[,id], dat2$tad), ]
  dat2$dvtm <- dat2[,dv] * dat2[,time]

  datauc <- dat2
  auclast <- AUC(datauc, time = time, id = id, dv = dv)
  names(auclast) <- c(id, "AUClast")
  aucmlast <- AUC(datauc, time = time, id = id, dv = "dvtm")
  names(aucmlast) <- c(id, "AUMClast")
  dat2$tad1 <- dat2$tad
  aucpart <- NULL
  if (!is.null(partialAUC)) {
    nauc <- length(partialAUC)/2
    for (z in seq(1, length(partialAUC), 2)) {
      tm1 <- partialAUC[z]
      tm2 <- partialAUC[z + 1]
      auc <- AUC(dat2[dat2[, "tad1"] >= tm1 & dat2[, "tad1"] <=
                       tm2, ], time = "tad1", id = id, dv = dv)
      names(auc) <- c(id, paste0("AUC", tm1, "-", tm2))
      if (z == 1) {
        aucpart <- rbind(aucpart, auc)
      }      else {
        aucpart[, paste0("AUC", tm1, "-", tm2)] <- auc[,
                                                       2]
      }
    }
    aucpart
  }  else {
    aucpart <- NULL
  }
  Cpart <- NULL
  if (!is.null(partialConc)) {
    nauc <- length(partialConc)
    for (z in 1:length(partialConc)) {
      tm1 <- partialConc[z]
      partc <- dat2[dat2[, "tad1"] == tm1, c(id, dv)]
      names(partc) <- c(id, paste0("C", tm1))

      if (z == 1) {
        Cpart <- rbind(Cpart, partc)
      }      else {
        Cpart<-left_join(Cpart, partc)
      }
    }
  } else {
    Cpart <- NULL
  }


  if (!is.null(n_lambda)) {
    dat3<-dat2
    dat3$time <- dat3$tad
    dat3$tmp <- seq(nrow(dat3))
    dat3 <- addvar(dat3, id, "tmp", "max(x)", "yes", "tmp2")
    head(dat3)
    dat3$tmp <- dat3$tmp2 - dat3$tmp
    dat3 <- dat3[dat3$tmp < n_lambda, ]
    test1 <- ddply(dat3[, c("uid", "time", "dv")], .(uid),
                   summarize, interc = lm(log(dv) ~ time)$coef[1], Lambda = lm(log(dv) ~
                                                                                 time)$coef[2] * -1, R2 = summary(lm(log(dv) ~
                                                                                                                       time))$r.squared, HL = (log(2)/lm(log(dv) ~ time)$coef[2]) *
                     -1, that = max(time))
    test1$n_lambda <- n_lambda
    test1$Clast_hat <- with(test1, exp(-Lambda * that + interc))
  head(dat3)
test1a <- ddply(dat3[, c("uid", "time", "dv","dvtm")], .(uid),
                summarize, intercc = lm(log(dvtm) ~ time)$coef[1],
                Lambdac = lm(log(dvtm) ~ time)$coef[2] * -1, R2c = summary(lm(log(dvtm) ~
                                                                              time))$r.squared, HLc = (log(2)/lm(log(dvtm) ~
                 time)$coef[2]) * -1, thatc = max(time))
    test1a$n_lambdac <- n_lambda
    test1a$Clast_hatc <- with(test1a, exp(-Lambdac * thatc +
                                            intercc))
  }  else {
    test1 <- NULL
  }
  if (TRUE %in% c(test1$HL < 0)) {
    test1$Warning.HL.Negative = ifelse(test1$HL, "yes", "")
  }


  dat2$time1 <- dat2$time

  min(dat2$dv[dat2$time >= dat2$time[dat2$dv == max(dat2$dv)]])
  time[dv == max(dv)]

    max <- addvar(dat2,"uid","dv","min(x)","yes","Cmin")
    max<-left_join(max,addvar(dat2,"uid","dv","max(x)","no","Cmax"))
    max<-left_join(max,addvar(dat2,"uid","time1","max(x)","no","Tlast"))
    clast<-max[max$time1==max$Tlast,c(id,dv)];names(clast)[2]<-"Clast"
    max<-lhmutate(max[max[,dv]==max$Cmax,c(id,"time1","Cmin","Cmax","Tlast")],"time1=Tmax")
    max<-left_join(max,clast)

    # ddply(dat2[, c("uid", "dv", "time", "time1")], .(uid),
    #            summarize, Cmax = max(dv), Tmax = time1[dv == max(dv)],
    #            Cmin = min(dv), Tlast = max(time1),
    #            Clast = dv[time == max(time)])
  maxa <- ddply(dat2, .(uid), summarize, Clastc = dvtm[time ==
                                                         max(time)])
  head(dat1)
  #test <- plyr::join(max, idss)
  test <- plyr::join(max, maxa)
  test <- plyr::join(test, auclast)
  test <- plyr::join(test, aucmlast)
  if (!is.null(n_lambda)) {
    test <- join(test, test1)
    test <- join(test, test1a)
    test$AUCinf_obs <- abs(as.numeric(as.character(test$AUClast)) +
                             test$Clast/test$Lambda)
    test$AUMCinf_obs <- abs(as.numeric(as.character(test$AUMClast)) +
                              test$Clastc/test$Lambdac)
    test$AUCinf_pred <- abs(as.numeric(as.character(test$AUClast)) +
                              test$Clast_hat/test$Lambda)
    test$AUMCinf_pred <- abs(as.numeric(as.character(test$AUMClast)) +
                               test$Clast_hatc/test$Lambdac)
    test$MRTlast <- test$AUMClast/test$AUClast
    test$MRTobs <- test$AUMCinf_obs/test$AUCinf_obs
    test$MRTpred <- test$AUMCinf_pred/test$AUCinf_pred
  }  else {
    test$MRTlast <- test$AUMClast/test$AUClast
  }
  if (!is.null(Cpart)) {
    test <- plyr::join(test, Cpart)
  }
  if (!is.null(aucpart)) {
    test <- plyr::join(test, aucpart)
  }
  test$interc <- test$that <- NULL
  test
  }


#' Derive Effective Half-life and Accumulation Ratio
#'
#' Require AUC of first dose, AUCtau and tau
#' @param data NCA results
#' @param id unique subject identifier
#' @param AUCsd AUCtau SD
#' @param AUCss AUCtau SS
#' @param OCC Identifier of SD and SS
#' @param TAU Dosing iterval
#' @keywords lh.ehl.rc
#' @export
#' @examples
#'
lh.ehl.rc<-function(data,AUCsd="AUCsd",AUCss="AUCss",TAU=24){
  data$Rc <- with(data, AUCss/AUCsd)
  data$EHL <- with(data, log(2) * TAU/(log(Rc/(Rc - 1))))
  data$TAU<-TAU
  data}
