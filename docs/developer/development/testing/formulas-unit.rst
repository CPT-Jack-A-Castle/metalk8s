Salt Formulas Unit Testing
==========================

Introduction
------------
This test suite aims to provide full coverage of Salt formulas rendering,
intending to protect formula designers from avoidable mistakes.

The tests are built using:

- ``pytest`` fixtures to simulate a real rendering context
- ``jinja2`` as a library, to extract the Jinja AST and infer coverage from
  rendering passes (more renderers may be covered in the future, if the need
  arises)

Goals / Non-goals
-----------------
The tests written here are designed as **unit tests**, covering only the
rendering functionality.

As such, a test will ensure that the *render-time* behaviour is tested (and
all branches are covered), and will verify the result's validity.

Providing coverage information will be paramount, to build the desired
protection (enforcing coverage will also improve the confidence in newly
created formulas).

These tests do not include integration or end-to-end evaluation of the
formulas.
Checking the validity of the rendered contents is only a possibility, and not
a primary goal for this test suite.

Implementation Plan
-------------------

Generic Test Behaviour
^^^^^^^^^^^^^^^^^^^^^^
Every rendering test will behave the same way:

#. Set up test fixtures
#. Read a formula
#. Render it from the desired context
#. Run some validity check(s) on the result

Configuration
^^^^^^^^^^^^^
Not all formulas are made the same, and some will only be renderable in
specific contexts.

To handle this situation, we define a series of supported context options to
customize the `test fixtures <Fixtures>`_, and a configuration file for
describing the context(s) supported by each formula.

Since we do not want to specify these for each and every formula, we define
a configuration structure, based on TOML, which builds on the natural
hierarchy of our Salt formulas.

As an example, assume that we only have a ``node_role`` fixture parameter.
A configuration file could look like:

.. code-block:: toml

   [default_opts]
   node_roles = [
     "ca",
     "bootstrap",
     "master",
     "infra",
     "node",
   ]
   skip = false

   [metalk8s.salt.master._opts]
   node_roles = ["bootstrap"]

   [metalk8s.repo._opts]
   node_roles = ["bootstrap"]

   [metalk8s.addons._opts]
   skip = true

Fixtures
^^^^^^^^
Formulas require some context to be available to render.
This context includes:

- Static information, like ``grains`` or ``pillar`` data
- Dynamic methods, through ``salt`` execution modules
- Extended Jinja functionality, through custom filters (likely provided by
  Salt)

The ``pytest`` fixtures defined with the tests should allow to setup a
rendering context through composition. Dynamic ``salt`` functions should
attempt to derive their results from other static fixtures when possible.

Validity
^^^^^^^^
The result of a formula rendering shall be validated by the tests.
As most formulas use the ``jinja|yaml`` rendering pipeline, the first validity
check implemented will only attempt to load the result as a YAML data
structure.

Later improvements may add:

- Structure validation (result is a map of string keys to list values, where
  each list contains either strings or single-key maps)
- Resolution of ``include`` statements
- Validity of requisite IDs (``require``, ``onchanges``, etc.)

Coverage
^^^^^^^^
Obtaining coverage information for non-Python code is not straightforward.
In the context of Jinja templates, some existing attempts can be found:

- `jinja_coverage <https://github.com/MrSenko/coverage-jinja-plugin>`_ is not
  maintained, though should give useful pointers
- `django_coverage_plugin <https://github.com/nedbat/django_coverage_plugin>`_
  is another interesting take, though likely too specific to Django

Given the above, we will create our own coverage plugin suited to our needs.

Macros Testing
^^^^^^^^^^^^^^
Another aspect we can address with these tests is unit-testing of Jinja
macros. This will ensure macros behaviour remains stable over time, and that
their intent is clearly expressed in test cases.

To perform such unit-testing, one may approach it as follows:

.. code-block:: python

   from jinja2 import Environment

   env = Environment(loader=FilesystemLoader('salt'))
   macro_tpl = env.get_template('metalk8s/macro.sls')

   # This is the exported `pkg_installed` macro
   pkg_installed = macro_tpl.module.pkg_installed
