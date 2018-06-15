#File: test_blocks.R
context("blocks tests")
source("data_upload.R")

block <- LoadBlock("https://lists.blocklist.de/lists/apache.txt", 8)

test_that("LoadBlock returns expected data for Apache",{
  expect_is(block, "data.frame")
})
