/**
 * @name Scratch
 * @description Find all flow sources in the project
 * @kind problem
 * @tags correctness
 * @problem.severity recommendation
 * @sub-severity low
 * @precision very-high
 * @id py/get-remote-flow-source
 */

import python
import semmle.python.Concepts

from ActiveThreatModelSource src
select src, "Tainted data source"
