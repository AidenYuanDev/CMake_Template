#include <gtest/gtest.h>

#include "add.h"
#include "sub.h"

// 跨模块的集成测试；模块自身的单元测试放在各模块的 test/ 目录下
TEST(IntegrationTest, AddThenSub) {
  ADD a(5, 6);
  SUB b(a.cal(), 1);
  EXPECT_EQ(b.cal(), 10);
}

TEST(IntegrationTest, SubEqualsAddOfNegative) {
  ADD a(10, -4);
  SUB b(10, 4);
  EXPECT_EQ(a.cal(), b.cal());
}
