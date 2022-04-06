from ensurepip import version
from setuptools import setup, find_packages

with open("README.MD") as readme_file:
    README = readme_file.read()

setup_args = dict(
    name="miniq",
    version="0.0.1",
    description="Python lib for miniQ",
    license="MIT",
    packages=find_packages(),
    author="Austin Chang",
    author_email="austinchang4@gmail.com",
    keywords=["miniq", "queue"],
    url="https://github.com/ac5tin/miniq-lib-python",
)
