# Muller C-Element

>  The **Muller C-element**, introduced by David E. Muller in 1959 during the design of the ILLIAC II computer ([Muller & Bartky, 1959](https://archive.org/details/theoryofasynchro75mull)), is a fundamental component in asynchronous digital circuit design. Acting as an event synchronizer or rendezvous gate, its output transitions to a specific logic level only when all of its inputs converge to that same level; otherwise, it retains its previous memory state ([Wikipedia](https://en.wikipedia.org/wiki/C-element)). Extensively referenced in the classic literature of clockless design—most notably in Ivan Sutherland's seminal work on *Micropipelines* ([Sutherland, 1989](https://www.google.com/search?q=https://doi.org/10.1145/63526.63532)) and foundational modern textbooks ([Sparsø & Furber, 2001](https://link.springer.com/book/10.1007/978-1-4757-3385-3))—this element enables strict handshake control without a global clock network. Recently, the C-element has seen renewed prominence in highly energy-efficient architectures, such as state-of-the-art asynchronous datapaths ([Balasubramanian & Liu, 2023](https://doi.org/10.1371/journal.pone.0289569)) and brain-inspired neuromorphic hardware ([Bagheriye & Kwisthout, 2021](https://doi.org/10.3389/fnins.2021.728086)), where asynchronous logic naturally mimics the event-driven behavior of biological neural networks.

---

## **References**

1. **[Bagheriye & Kwisthout, 2021]** Bagheriye, L., & Kwisthout, J. "Brain-Inspired Hardware Solutions for Inference in Bayesian Networks." *Frontiers in Neuroscience*, 15. DOI: [10.3389/fnins.2021.728086](https://doi.org/10.3389/fnins.2021.728086)

2. **[Balasubramanian & Liu, 2023]** Balasubramanian, P., & Liu, W. "High-speed and energy-efficient asynchronous carry look-ahead adder." *PLOS ONE*, 18(8), e0289569. DOI: [10.1371/journal.pone.0289569](https://doi.org/10.1371/journal.pone.0289569)

3. **[Muller & Bartky, 1959]** Muller, D. E., & Bartky, W. S. "A Theory of Asynchronous Circuits." *Proceedings of an International Symposium on the Theory of Switching*, 29, 204-243. Available at: [Internet Archive](https://archive.org/details/theoryofasynchro75mull)

4. **[Sparsø & Furber, 2001]** Sparsø, J., & Furber, S. (Eds.). *Principles of Asynchronous Circuit Design: A Systems Perspective*. Springer Science & Business Media. DOI: [10.1007/978-1-4757-3385-3](https://link.springer.com/book/10.1007/978-1-4757-3385-3)

5. **[Sutherland, 1989]** Sutherland, I. E. "Micropipelines" (Turing Award Lecture). *Communications of the ACM*, 32(6), 720-738. DOI: [10.1145/63526.63532](https://www.google.com/search?q=https://doi.org/10.1145/63526.63532)

6. **[Wikipedia]** Wikipedia contributors. "C-element." *Wikipedia, The Free Encyclopedia*. Available at: [en.wikipedia.org/wiki/C-element](https://en.wikipedia.org/wiki/C-element)

## Anotações 

> ; 
