#clear the workspace
rm(list=ls())

#load libraries, etc.
library(dplyr)
library(tidyr)
library(stringr)
library(readtext)

#Function to clean up the text data once its been read in by readLines
cleanup_vip_text_data <- function(text_lines_object){
	filter_pattern <- "(^Fix)|(^Use)"
	only_fixations_events_labels <- str_subset(text_lines_object,filter_pattern)
	output_list <-c()
	for (each_element in 1:length(only_fixations_events_labels)){
		if str_detect(only_fixations_events_labels[each_element],"UserEvent"){
			within_trial_flag <- 1
			image_name <- str_split(only_fixations_events_labels[each_element],"Message: ")[[1]][2]
			this_trial_list <- c()
			while (within_trial_flag==1){
				for (each_within_trial_element in (each_element+1):length(only_fixations_events_labels)){
					if (str_detect(only_fixations_events_labels[each_within_trial_element],"Fixation")==TRUE){
						this_trial_list <- c(this_trial_list,only_fixations_events_labels[each_within_trial_element])
					} else {
						within_trial_flag <- 0
					}
				}
			}
			image_name <- rep(image_name,length(this_trial_list))
			output_list <- c(output_list,this_trial_list)
		}
	}
	return(output_list)
}

#Get a list of all the files in the vip dataset data folder
vip_dataset_files <- list.files(path_to_files,pattern='*.txt',full.names=TRUE)

