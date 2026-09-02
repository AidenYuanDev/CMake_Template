#include <gtest/gtest.h>

#include "add.h"

TEST(AddTest, PositiveNumbers) {
  ADD a(5, 6);
  EXPECT_EQ(a.cal(), 11);
}

TEST(AddTest, NegativeNumbers) {
  ADD a(-3, -4);
  EXPECT_EQ(a.cal(), -7);
}

TEST(AddTest, Zero) {
  ADD a(0, 0);
  EXPECT_EQ(a.cal(), 0);
}
