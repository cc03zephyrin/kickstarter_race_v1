#install.packages("pak")
#install.packages("predictrace")
library(readxl)
selected_columns=read_excel('CreatorName0408_usd.xlsx')
library(predictrace)#new package

# Direct application of predict_race and predict_gender, assuming they handle NA
race_predictions_Last <- predict_race(selected_columns$LastName_new, probability = FALSE)
race_predictions_First=predict_race(selected_columns$FirstName_new,  probability =FALSE,surname=FALSE)

gender_predictions <- predict_gender(selected_columns$FirstName_new, probability = FALSE)
race_predictions_Verified_Last <- predict_race(selected_columns$LastNameVerified, probability = FALSE)
race_predictions_Verified_First=predict_race(selected_columns$FirstNameVerified,  probability =FALSE,surname=FALSE)
gender_predictions_Verified <- predict_gender(selected_columns$FirstNameVerified, probability = FALSE)

selected_columns$LiklyRaceLast <- race_predictions_Last$likely_race
selected_columns$LiklyRaceFirst=race_predictions_First$likely_race
# Create the LiklyRace column
selected_columns$LiklyRace <- ifelse(is.na(selected_columns$LiklyRaceLast), selected_columns$LiklyRaceFirst, selected_columns$LiklyRaceLast)

# If LiklyRaceLast is NA, LiklyRace takes the value of LiklyRaceFirst; otherwise, it takes the value of LiklyRaceLast


selected_columns$LiklyGender_new <- gender_predictions$likely_gender

selected_columns$LiklyRaceVerifiedLast <- race_predictions_Verified_Last$likely_race
selected_columns$LiklyRaceVerifiedFirst=race_predictions_Verified_First$likely_race

# Create the LiklyRaceVerified column
selected_columns$LiklyRaceVerified <- ifelse(is.na(selected_columns$LiklyRaceVerifiedLast), selected_columns$LiklyRaceVerifiedFirst, selected_columns$LiklyRaceVerifiedLast)

# If LiklyRaceVerifiedLast is NA, LiklyRaceVerified takes the value of LiklyRaceVerifiedFirst; otherwise, it takes the value of LiklyRaceVerifiedLast


selected_columns$LiklyGenderVerified <- gender_predictions_Verified$likely_gender


# Write the modified DataFrame back to an Excel file
library(openxlsx)
write.xlsx(selected_columns, 'selected_columns_with_predictions_0421_usd.xlsx')
