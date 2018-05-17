#File: test_load_data.R
context("load_data tests")

dataset <- LoadData("./cybercrime.xlsx")

test_that("LoadData returns expected data when passing a filename",{
  expect_is(dataset, "data.frame")
})
