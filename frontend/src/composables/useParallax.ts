export function useParallax() {
  const handleScroll = (element: HTMLElement, speed: number = 0.5) => {
    const scrolled = window.pageYOffset
    const offset = element.offsetTop
    const rate = (scrolled - offset) * speed
    
    element.style.transform = `translateY(${rate}px)`
  }
  
  return { handleScroll }
}
