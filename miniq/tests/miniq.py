import unittest

from miniq.miniq import MiniQ


class TestMiniQ(unittest.TestCase):
    def test_add_task(self):
        m = MiniQ("localhost:8080")
        m.add_task("test", bytes("test abc 123", "UTF-8"))


if __name__ == "__main__":
    unittest.main()
